-- Exercício 02: Crie uma função tipoTriangulo que determina o tipo 
-- do triângulo formado pelos três lados x, y, z.

-- verifica o tipo de triangulo
tipoTriangulo :: Int -> Int -> Int -> String
tipoTriangulo x y z
    | equilatero == True = "Triangulo Equilatero"
    | isosceles == True = "Triangulo Isosceles"
    | otherwise = "Triangulo Escaleno"
    where
        equilatero = x == y && y == z
        isosceles = eqdif x y z || eqdif x z y || eqdif y z x 
        eqdif x y z =  x == y && y /= z 
        
main = do
    print(tipoTriangulo 5 5 5 )  -- eh triangulo equilatero
    print(tipoTriangulo 5 5 10)  -- eh triangulo isosceles
    print(tipoTriangulo 5 4 3 )  -- eh triangulo escaleno
