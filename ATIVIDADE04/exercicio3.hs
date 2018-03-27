-- Exercício 03: Faça uma função que calcule a soma da diagonal secundária de uma matriz.

-- Exercicio quase identico ao anterior. A diagonal secundaria corresponde aos elementos 4, 7, 10 e 13.
-- Basta inverter os elementos de cada lista e aplicar a funcao do exercicio anterior.

somaDiagonalSecundaria xs = sum $ map head $ zipWith drop [0..] (map reverse matriz)

matriz = [[ 1,2, 3, 4],[ 5, 6, 7, 8],[ 9,10,11,12], [13,14,15,16]]

main = do
    print(somaDiagonalSecundaria matriz)
