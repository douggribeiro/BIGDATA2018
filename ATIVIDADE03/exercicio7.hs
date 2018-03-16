-- Exercício 07: Implemente uma função collatzLen x que retorna o 
-- tamanho da lista formada pela aplicação repetida de collatz sobre 
-- o valor x até que essa chegue no número 1.

-- verifica numero e atual de acordo, adicionando cada elemento gerado na
-- lista [n]
collatz :: Int -> [Int]
collatz 1 = [1]
collatz n = n:sequencia
    where sequencia
            | even n = collatz (n `div` 2)
            | otherwise = collatz (n*3 + 1)

-- retorna tamanha da lista gerada pela funcao collatz
collatzLen :: Int -> Int
collatzLen n = length (collatz n)

main = do
    print(collatz 2)      -- [2,1]
    print(collatzLen 2)   -- 2
    print(collatz 4)      -- [4,2,1]
    print(collatzLen 4)   -- 3
    print(collatz 10)     -- [10,5,16,8,4,2,1]
    print(collatzLen 10)  -- 7
