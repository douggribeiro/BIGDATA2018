-- Exercício 01: Faça uma função que gere uma matriz identidade de tamanho n.

-- funcao que gera matrix identidade de tamanho n:
-- quando j for igual a i, retorna a posicao de True (que é igual 1), se forem diferentes, retorna a posicao de False (que é igual a 0)
matrizId :: Int -> [[Int]]
matrizId n = [ [fromEnum $ i == j | i <- [1..n]] | j <- [1..n]]

-- funcao para mostrar a matrix de uma forma nao vetorial:
-- transforma cada elemtno em string, adiciona caractere espaco entre cada um adiciona quebra de linha a cada lista
mostraMatriz :: [[Int]] -> String
mostraMatriz = unlines . map (unwords . map show)


main = do
    print(matrizId 7)  -- vetorial
    putStr $ mostraMatriz $ matrizId 7 -- nao vetorial
