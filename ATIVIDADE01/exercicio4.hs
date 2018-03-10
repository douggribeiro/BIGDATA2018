-- Exercício 04: Faça uma função mult35 x que retorne True caso a entrada 
-- seja múltiplo de 3 e 5 e False caso contrário.

mult35 :: Integer -> Bool
mult35 a 
    | isDiv 3 && isDiv 5 = True 
    | otherwise = False 
    where
        isDiv n = a `rem` n == 0

main = do
    print (mult35 15)
    print (mult35 30)
    print (mult35 70)
    
