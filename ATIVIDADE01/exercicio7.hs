--  Faca uma função que receba um ângulo a e retorne uma tupla contendo 
-- o seno da metade desse ângulo utilizando a identidade:

sindx2 :: Double -> (Double, Double)
sindx2 x = (x1, x2)
    where
        x1 = equation x
        x2 = (-1)*equation x 
        equation n = sqrt((1-cos(n)/2))

main = do
    print (sindx2 0)
    print (sindx2 pi)

