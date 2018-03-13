-- Exercício 03: Implemente uma função que faz a multiplicação 
-- etíope entre dois números.

multEtiope :: Int -> Int -> Int
multEtiope m n 
    | m == 1 = n
    | odd m == True = n + multEtiope (m `div` 2) (n*2)
    | otherwise = multEtiope (m `div` 2) (n*2) 
    
main = do
    print(multEtiope 13 21 )
