-- Exercício 02: Crie uma função projectEuler5 que retorna o primeiro 
-- número natural que retorna True para a função do exercício anterior. 
-- Pense em como reduzir o custo computacional.

-- do exercicio 1 (para validar)
divisivel20 :: Int -> Bool 
divisivel20 x 
    | b == 20 = True
    | otherwise = False
    where 
        b = length [ a | a <- [1..20], x `mod` a  == 0]

-- foldr1 pega dois itens da lista e aplica a funcao do minimo divisor comum lcm
projectEuler5 :: Int -> Int
projectEuler5 x = foldr1 lcm [1..x]

-- executa o projectEuler5 e valida com o divisivel20
main = do
    print(projectEuler5 20) -- imprime numero
    print(divisivel20 $ projectEuler5 20) -- valida numero
