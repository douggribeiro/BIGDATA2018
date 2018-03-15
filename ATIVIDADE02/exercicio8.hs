-- Exercício 08: Faça uma função que calcule o elemento (i,j) do triângulo de pascal.

fatorial :: Int -> Int 
fatorial 0 = 1
fatorial 1 = 1
fatorial n = n * fatorial (n-1)


coefBinominal :: Int -> Int -> Int
coefBinominal i j = fatorial(i) `div` ((fatorial j) * (fatorial (i-j)))

main = do

-- testes
    print (coefBinominal 0 0 ) -- 1
    print (coefBinominal 1 0 ) -- 1
    print (coefBinominal 1 1 ) -- 1
    print (coefBinominal 2 0 ) -- 1
    print (coefBinominal 2 1 ) -- 2
    print (coefBinominal 2 2 ) -- 1
    print (coefBinominal 3 0 ) -- 1
    print (coefBinominal 3 1 ) -- 3
    print (coefBinominal 3 2 ) -- 3
    print (coefBinominal 3 3 ) -- 1
            



