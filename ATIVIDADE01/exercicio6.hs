-- Exercício 06: Faça uma função que recebe um tipo Integer 
-- e retorna ele dividido por 2:



div2d :: Integer -> Double
div2d a = (fromIntegral a) / 2

main = do
    print (div2d 4)
    print (div2d 11)


