--Exercício 05: Faça uma função que calcule a soma dos dígitos de um número.

import Data.Char (digitToInt) -- transforma cada digito em elemento de lista

somaDigitos :: Int -> Int
somaDigitos n = sum . map digitToInt $ show n

main = do
    print (somaDigitos 1234) -- 10
    print (somaDigitos 123459999999999999) -- 132
