-- Exercício 05: Faça um programa que retorne True caso a entrada 
-- seja menor que -1 ou (maior que 1 E múltiplo de 2), e False caso contrário.

check :: Integer -> Bool
check a 
    | (a < -1) || (isDiv 2 && a > 1) = True 
    | otherwise = False 
    where
        isDiv n = a `rem` n == 0

main = do
    print (check (-2))
    print (check 4)
    print (check 3)

