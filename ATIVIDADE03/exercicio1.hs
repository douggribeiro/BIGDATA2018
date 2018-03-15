-- Exercício 01: Crie uma função divisivel20 x que retorna verdadeiro se x 
-- for divisível por todos os números de 1 a 20.


divisivel20 :: Int -> Bool 
divisivel20 x 
    | b == 20 = True
    | otherwise = False
    where 
    b = length [ a | a <- [1..20], x `mod` a  == 0]


main = do
    print(divisivel20 10)
    print(divisivel20 11)
    print(divisivel20 232792560)
