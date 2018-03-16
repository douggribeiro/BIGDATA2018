-- Exercício 05: Faça uma função para calcular o produto escalar entre dois vetores.

vetorA = [1,2,3]
vetorB = [2,3,4] 

-- (*) zipWith multiplica cada elemento do vetorA com o respectivo no vetorB
produtoEscalarXYZ :: [Int] -> [Int] -> Int
produtoEscalarXYZ a b = sum $ zipWith (*) a b

main = do
    print(produtoEscalarXYZ vetorA vetorB)
