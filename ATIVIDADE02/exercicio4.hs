-- Exercício 04: Faça uma função que determine se um número é primo.

ehPrimo :: Int -> String
ehPrimo a 
    | b  = "Eh primo"
    | otherwise = "Nao eh primo"
    where 
        b = null [ x | x <- [2..a - 1], a `mod` x  == 0 ]


main = do
    print(ehPrimo 10)
    print(ehPrimo 11)
    print(ehPrimo 13)
    print(ehPrimo 2)
