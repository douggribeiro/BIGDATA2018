-- Exercício 06: Faça uma função que calcule a persistência aditiva de um número.

import Data.Char (digitToInt) -- util para transformar cada digito em elemento de lista

i = 1
j = 1
somaDigitos n = sum . map digitToInt $ show n

persistenciaDigitos :: Int -> Int
persistenciaDigitos x 
    | y < 10 = i
    | otherwise = persistenciaDigitos $ somaDigitos y 
    where
        y = somaDigitos x
        i = j + 1
        



main = do
    print ( persistenciaDigitos 1234599999)




