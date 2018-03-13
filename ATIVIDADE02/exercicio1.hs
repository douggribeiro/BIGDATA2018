-- Exercício 01: Crie uma função ehTriangulo que determina se três 
-- lados x, y, z podem formar um triângulo.


ehTriangulo :: Int -> Int -> Int -> Bool
ehTriangulo x y z
    | verificaTriangulo == True = True
    | otherwise = False
    where
        l1 = confirmaLado x y z
        l2 = confirmaLado y x z
        l3 = confirmaLado z x y
        confirmaLado x y z = abs(y-z) < x && x < (y+z) 
        verificaTriangulo = l1 && l2 && l3
        
main = do
    print(ehTriangulo 5 10 9 ) -- eh triangulo
    print(ehTriangulo 5 2 1 )  -- nao eh triangulo

