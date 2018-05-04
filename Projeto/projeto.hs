-- ghc -o Main Main.hs ; ./Main ; rm Main
-- 
-- Importar bibliotecas de importancia
import Data.List (nub, elemIndices,transpose)
import qualified Data.Map as M
import Data.Map (Map, (!))
import Text.CSV

-- Novos tipos
type Atributo = String
type Classe = String
type Entropia = Double
type DataSet = [([String], Classe)]

-- Separacao atributos, classes e entropia
amostras :: DataSet -> [[String]]
amostras x = map fst x

classes :: DataSet -> [String]
classes x = map snd x

splitAtributo :: [(Atributo, Classe)] -> Map Atributo [Classe]
splitAtributo fc = foldl (\m (f,c) -> M.insertWith (++) f [c] m) M.empty fc

splitEntropia :: Map Atributo [Classe] -> M.Map Atributo Entropia
splitEntropia m = M.map calculaEntropia m


-- Classificação de dados utilizando algoritmo ID3
-- processo para importar CSV
main = do
  arquivoCSV <- parseCSVFromFile "arquivo33M.csv"
  either (error "Arquivo Invalido! Nao eh CSV") iniciaProcesso arquivoCSV


iniciaProcesso csv = do
  let dadosCSV = map (\x -> (init x, last x)) -- separa dados em tupla com atributo e classificador
  let limpaCSV = filter (\x -> length x > 1)  -- remove atributos vazios. Sem isso da erro index
  let dadosLimpos = dadosCSV $ limpaCSV csv   -- tuplas prontas para uso


-- Calculo Entropia : Soma -Pi*log2*Pi
calculaEntropia :: (Eq e) => [e] -> Entropia
calculaEntropia xs = sum $ map (\x -> probabilidade x * info x) xs
  where probabilidade x = (length' (elemIndices x xs)) / (length' xs)
        info x = negate $ logBase 2 (probabilidade x)
        length' xs = fromIntegral $ length xs


-- Calcula ganho info com base na entropia anterior
-- obtem os atributos, gera proporcao de cada elemento e sua entropia. 
-- Subtrai entropia anterior com a nova entropia calculada
ganhoInfo :: [Classe] -> [(Atributo, Classe)] -> Double
ganhoInfo s a = calculaEntropia s - novaInfo
  where mapEntropia = splitEntropia $ atributos
        atributos = splitAtributo a   
        somaEntropia = M.map (\x -> (fromIntegral.length) x / (fromIntegral.length) s) atributos 
        novaInfo = M.foldrWithKey (\k a b -> b + a*(mapEntropia!k)) 0 somaEntropia


-- escolhe ganho de maior valor
maiorGanhoInfo :: DataSet -> Int
       
-- falta terminar escolha maior ganho de info e gerar arvore 



