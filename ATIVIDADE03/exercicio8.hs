-- Exercício 08: Encontre o número x entre 1 e 1.000.000 que tem a 
-- maior sequência de Collatz.

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


pmax x n = x `max` ( collatzLen n, n )
solve xs = foldl pmax (1,1) xs

main = do
    print(solve [1..1000000])
