# Douglas Galetti Ribeiro  - BigData 2018
#

import os.path
import math


### Funcoes pre processamento da base de dados
def preProcessamento():

    listaPronta = processaDados('/home/rockman/BIGDATA2018/Spark_project', 'abc.txt')
    
    # adiciona atributos (cabecalho) ao arquivo processado
    dados = []
    atributosAmostra = ['CAMPANHA', 'SEMANA', 'ALCANCE', 'ACEITE', 'PERFORMANCE']
    dados.append(atributosAmostra)

    for valores in listaPronta:
        dados.append(valores)
    return dados, atributosAmostra


# pre-processamento dos dados para formato legivel ao ID3
def processaDados (path, nomeArquivo):

    arquivo = os.path.join(path, nomeArquivo ) 

    # cria RDD, mapeia arquivo e obtem apenas os valores de interesse
    valores = (sc.textFile(arquivo)).map(lambda x: x.split(',')).map(lambda x: (x[0], int(x[1]), int(x[2]), int(x[3])))

    # reduce da campanha com a soma dos totais
    totais = valores.map(lambda x: (x[0],x[1])).reduceByKey(lambda x,y: x+y)

    # reduce da campanha com a soma dos deliveries
    deliv = valores.map(lambda x: (x[0],x[2])).reduceByKey(lambda x,y: x+y)

    # reduce da campanha com a soma dos acceptances
    accept = valores.map(lambda x: (x[0],x[3])).reduceByKey(lambda x,y: x+y)

    # junta valores segundo o grupo (campanha)
    joinValores = totais.join(deliv).join(accept).map(lambda x: (x[0],x[1][0][0],x[1][0][1],x[1][1]))

    # calcula percentagem delivery/total e acceptance/delivery
    calculaPerc = joinValores.map(lambda x: (x[0],int(x[2]/x[1]*100) ,int(x[3]/x[2]*100)))

    # classifica percentual delivery
    deliveryPerc = calculaPerc.map(lambda x: (x[0],x[1] < 50 and 'baixo' 
                                         or (x[1] >=50 and x[1] <70 and 'normal') 
                                         or (x[1] >= 70 and 'alto'),x[2]))

    # classifica percentual acceptance
    acceptPerc = deliveryPerc.map(lambda x: (x[0],x[1],x[2] < 2 and 'baixo' 
                                           or (x[2] >=2 and x[2] <3 and 'normal') 
                                           or (x[2] >= 3 and 'alto')))

    # classifica campanha com base nas classificacoes de delivery e acceptance
    classifica = acceptPerc.map(lambda x: (x[0], x[1],x[2], 
                             (x[1] == 'baixo' and x[2] == 'baixo' and 'PESSIMO') 
                                      or (x[1] == 'baixo' and x[2] == 'normal' and 'RUIM' )
                                      or (x[1] == 'baixo' and x[2] == 'alto' and 'BOM')
                                      or (x[1] == 'normal' and x[2] == 'baixo' and 'RUIM')
                                      or (x[1] == 'normal' and x[2] == 'normal' and 'BOM')
                                      or (x[1] == 'normal' and x[2] == 'alto' and 'BOM')
                                      or (x[1] == 'alto' and x[2] == 'baixo' and 'PESSIMO')
                                      or (x[1] == 'alto' and x[2] == 'normal' and 'BOM')
                                      or (x[1] == 'alto' and x[2] == 'alto' and 'EXCELENTE') 
                                     ))
    listaPronta = classifica.map(lambda x: [x[0].split(';'),x[1],x[2],x[3]]).map(lambda x: [x[0][0],x[0][1],x[1],x[2],x[3]]).collect()
    return listaPronta



### Funcoes Classificador ID3
def mapCabecalho(cabecalhoData):
    
    # equivalente ao Map, gera atributos e valores. Retorna nome e index
    nomeIndex = {}
    indexNome = {}
    for i in range(0, len(cabecalhoData)):
        nomeIndex[cabecalhoData[i]] = i
        indexNome[i] = cabecalhoData[i]
    return indexNome, nomeIndex


def obterColunasAmostra(amostra, atributosAmostra):
    
    # mapeia colunas da amostra (incluindo o cabecalho) e considera apenas as colunas desejadas
    dadosCabecalho = list(amostra['cabecalho'])
    dadosLinha = list(amostra['linhas'])
    mapeiaColunas = list(range(0, len(dadosCabecalho)))
    colunasObtidas = [amostra['nomeIndex'][nome] for nome in atributosAmostra]
    colunasRemovidas = [indexCol for indexCol in mapeiaColunas if indexCol not in colunasObtidas]

    # deleta todas as colunas que nao fazem parte da amostra
    for deletaColuna in sorted(colunasRemovidas, reverse=True):
        del dadosCabecalho[deletaColuna]
        for l in dadosLinha:
            del l[deletaColuna]

    # retorna amostra mapeada apenas com as colunas desejadas
    indexNome, nomeIndex = mapCabecalho(dadosCabecalho)
    return {'cabecalho': dadosCabecalho, 'linhas': dadosLinha,'nomeIndex': nomeIndex, 'indexNome': indexNome}



def valoresUnicos(dados):
    
    # Garante que a amostra tenha apenas valores unicos (importante para calculo da entropia)
    indexNome = dados['indexNome']
    indexadores = indexNome.keys()
    
    # mapeia chaves e atributos da amostra
    mapeiaValor = {}
    for index in iter(indexadores):
        mapeiaValor[indexNome[index]] = set()

    # gera nova amostra com atributos unicos
    for dadosLinha in dados['linhas']:
        for index in indexNome.keys():
            nomeAtributo = indexNome[index]
            val = dadosLinha[index]
            if val not in mapeiaValor.keys():
                mapeiaValor[nomeAtributo].add(val)
    return mapeiaValor



def obtemDecisao(dados, atributo):
    
    # recebe amostra de dados e o atributo correspondente
    linhas = dados['linhas']
    indexColunas = dados['nomeIndex'][atributo]    
    atributos = {}
    
    # adiciona 1 ao valor caso ele ja exista. Basicamente gera a frequencia do atributo
    for l in linhas:
        valor = l[indexColunas]
        if valor in atributos:
            atributos[valor] = atributos[valor] + 1
        else:
            atributos[valor] = 1
    return atributos


def calculaEntropia(i, atributos):
    
    valorEntropia = 0
    for label in atributos.keys():
        probabilidade = atributos[label] / i
        valorEntropia += - probabilidade * math.log(probabilidade, 2)
    return valorEntropia


# particionamento: importante pra conseguir gerar/calcular os ramos da arvore de decisao
# encontrei alguns codigos em java e outros em python que usavam esse artificio para gerar a
# arvore de decisao, meu maior problema. 
def particionamentoDados(data, group_att):
    
    particao = {}
    dadosLinhas = data['linhas']
    particaoAtributoIndex = data['nomeIndex'][group_att]
    
    # se o atributo n~ao estiver na particao, adiciona. Utilizado posteriormente para gerar um dicionario de nos
    for linha in dadosLinhas:
        valorLinha = linha[particaoAtributoIndex]
        if valorLinha not in particao.keys():
            particao[valorLinha] = {'nomeIndex': data['nomeIndex'],'indexNome': data['indexNome'],'linhas': list()}
        particao[valorLinha]['linhas'].append(linha)
    return particao


def calculoEntropiaParticao(data, splitAtributo, atributo):

    dadosLinhas = data['linhas']
    i = len(dadosLinhas)
    particao = particionamentoDados(data, splitAtributo)

    entropia = 0

    # para cada particao de dados gerada, calcula a entropia
    for valorParticao in particao.keys():
        particionado = particao[valorParticao]
        parteParticionado = len(particionado['linhas'])
        atributosParticionado = obtemDecisao(particionado, atributo)
        entropiaParticionado = calculaEntropia(parteParticionado, atributosParticionado)
        entropia = entropia + parteParticionado / i * entropiaParticionado
    return entropia, particao


def atributoComum(atributos):
    
    atributoComum = max(atributos, key=lambda x: atributos[x])
    return atributoComum


# funcao principal. Onde o ID3 efetivamente ocorre
def classificador(amostra, unicos, atributosRestantes, atributo):
    
    node = {}
    atributos = obtemDecisao(amostra, atributo)
    
    # sem atributos restantes, termina o no
    if len(atributosRestantes) == 0:
        node['atributo'] = atributoComum(atributos)
        return node

    # se tem atributos a processar, processa cada um e gera o no
    if len(atributos.keys()) == 1:
        node['atributo'] = next(iter(atributos.keys()))
        return node

    # calculo da entropia para a amostra e definicao do ganho de info
    n = len(amostra['linhas'])
    ent = calculaEntropia(n, atributos)
    maxInfoGain = None
    maxInfoGainAtributo = None
    maxInfoGainParticao = None

    # faz o calculo da entropia da particao existente caso haja
    # depois exeucta o calulo do ganho de informacao para a particao
    for restoAtributo in atributosRestantes:
        entropia, particao = calculoEntropiaParticao(amostra, restoAtributo, atributo)
        infoGain = ent - entropia
        
        # obtem o maior ganho de informacao para escolher qual particao e atributos sao nos de decisao, por exemplo.
        if maxInfoGain is None or infoGain > maxInfoGain:
            maxInfoGain = infoGain
            maxInfoGainAtributo = restoAtributo
            maxInfoGainParticao = particao

    # se for homogeneo, pega o atributo em comum e gera no      
    if maxInfoGain is None:
        node['atributo'] = atributoComum(atributos)
        return node

    # define atributo e nos conforme valores calculados
    node['atributo'] = maxInfoGainAtributo
    node['nodes'] = {}
    
    # calculo dos atributos dos ramos do no
    atributosRestantesRamos = set(atributosRestantes)
    atributosRestantesRamos.discard(maxInfoGainAtributo)
    valoresUnicos = unicos[maxInfoGainAtributo]

    # adiciona o atributo ao dicionario
    for valorAtributos in valoresUnicos:
        if valorAtributos not in maxInfoGainParticao.keys():
            node['nodes'][valorAtributos] = {'atributo': atributoComum(atributos)}
            continue
        partition = maxInfoGainParticao[valorAtributos]
        
        # recursao. Ocorre ate que toda a amostra tenha sido analisada.
        # node['nodes'] eh um dicionario com todos os nos e ramos gerados
        node['nodes'][valorAtributos] = classificador(partition, unicos, atributosRestantesRamos, atributo)
    return node



def executaID3(dados,atributosAmostra):

    # o que queremos descobrir? (usado pra comparar o cabecalho e eliminar a coluna correspondente)
    Decisao = 'PERFORMANCE'
    
    # le cabecalho, mapeia seus valores, adiciona valores da amostra, remove ultima coluna (Decisao) da amostra 
    cabecalhoData = dados[0]
    indexNome, nomeIndex = mapCabecalho(cabecalhoData)
    amostra = { 'cabecalho': cabecalhoData,'linhas': dados[1:],'nomeIndex': nomeIndex,'indexNome': indexNome}
    amostra = obterColunasAmostra(amostra, atributosAmostra)
    restoAtributos = set(amostra['cabecalho'])
    restoAtributos.remove(Decisao)
    
    # equivalente ao reduce
    unicos = valoresUnicos(amostra)
    
    # chama classificador ID3 e mostra a arvore
    arvore = classificador(amostra, unicos, restoAtributos, Decisao)
    print(arvore)
    return 

   
### Main 
(dados,atributosAmostra) = preProcessamento()
executaID3(dados,atributosAmostra)


