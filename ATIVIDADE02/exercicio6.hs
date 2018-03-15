-- Exercício 06: Faça uma função que calcule a persistência aditiva de um número.

import Data.Char (digitToInt) -- util para transformar cada digito em elemento de lista


somaDigitos n = sum . map digitToInt $ show n

-- enquanto numero final maior que 10, continue fazendo a persistencia
persistenciaDigitos :: Int -> Int -> Int
persistenciaDigitos x i 
    | somaDigitos x > 10 = persistenciaDigitos (somaDigitos x) (i+1)
    | otherwise = i 
          
         


main = do 
    let i = 1
    print ( persistenciaDigitos 123456789 i) -- 123456789 vira 45 que vira 9 (duas vezes)
    print ( persistenciaDigitos 123 i)       -- 123 vira 6 (uma vez)




