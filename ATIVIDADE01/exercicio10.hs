-- Exercício 10: Crie uma tupla em que o primeiro elemento tem metade 
-- dos anos bissextos e o segundo elemento a outra metade.

lista = [ a | a <- [1..2018], a `rem` 400 == 0 ||  a `rem` 4 == 0 && a `rem` 10 /= 0 ] 


-- se a quantidade de indices nao for par, adicionar +1, dividir por 2 e gerar as tuplas
getTamanho :: Int -> Int
getTamanho tamanho 
    | isDiv 2 == 0 = tamanho `div` 2
    | otherwise = (((tamanho)+1) `div` 2)
    where
        isDiv n = tamanho `rem` n 


main = do
    
    let (ys,zs) = splitAt (getTamanho(length lista)) lista
    print (ys)
    print (zs)

