-- Exercício 06: Crie a função collatz x que retorna x/2, 
-- se x for par e (3x+1) se for ímpar.


-- verifica numero e atual de acordo, adicionando cada elemento gerado na
-- lista [n]
collatz :: Int -> [Int]
collatz 1 = [1]
collatz n = n:sequencia
    where sequencia
            | even n = collatz (n `div` 2)
            | otherwise = collatz (n*3 + 1)


main = do
    print(collatz 2)
    print(collatz 4)
    print(collatz 10)


