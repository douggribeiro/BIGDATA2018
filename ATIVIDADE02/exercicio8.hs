-- Exercício 08: Faça uma função que calcule o elemento (i,j) do triângulo de pascal.

fatorial :: Int -> Int 
fatorial 0 = 1
fatorial 1 = 1
fatorial n = n * fatorial (n-1)

elementoPascal :: Int -> Int -> Int
elementoPascal i j = fatorial(i) `div` ((fatorial j) * (fatorial (i-j)))

main = do

-- testes
    print (elementoPascal 0 0 ) -- 1
    print (elementoPascal 1 0 ) -- 1
    print (elementoPascal 1 1 ) -- 1
    print (elementoPascal 2 0 ) -- 1
    print (elementoPascal 2 1 ) -- 2
    print (elementoPascal 2 2 ) -- 1
    print (elementoPascal 3 0 ) -- 1
    print (elementoPascal 3 1 ) -- 3
    print (elementoPascal 3 2 ) -- 3
    print (elementoPascal 3 3 ) -- 1
