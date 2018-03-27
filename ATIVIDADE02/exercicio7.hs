-- Exercício 07: Faça uma função que calcule o coeficiente binomial de (m,n).

fatorial :: Int -> Int 
fatorial 0 = 1
fatorial 1 = 1
fatorial n = n * fatorial (n-1)

coefBinominal :: Int -> Int -> Int
coefBinominal m n = fatorial(m) `div` ((fatorial n) * (fatorial (m-n)))


main = do
    print (coefBinominal 5 2)   -- 10
    print (coefBinominal 10 6)  -- 210
    print (coefBinominal 10 10) -- quando m = n que eh 1 
    print (coefBinominal 10 0)  -- quando n = 0 que eh 1
    print (coefBinominal 10 1)  -- quando n = 1 que eh m, neste exemplo, 10
