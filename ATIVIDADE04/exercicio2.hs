-- Exercício 02: Faça uma função que calcule a soma da diagonal principal de uma matriz.


-- Explicacao da logica:
-- zipWith pega uma linha da matrix, aplica drop de 0 a "infinito" para cada linha. Para cada linha processada, aplica head obtendo apenas o primeiro elemento.
-- Por exemplo, uma matrix [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]
-- a primeira linha [1,2,3,4] apenas o head é aplicado, resultando em 1;
-- a segunda linha [5,6,7,8] é removido o primeiro elemento, 5, e aplicado head resultando em 6;
-- a terceira linha [ 9,10,11,12] sao removidos os dois primeiros elementos e aplicado head resultando em 11;
-- a ultima linha [13,14,15,16] sao removidos os tres primeiros elementos, aplicado head resultando em 16.
-- a soma dos elementos é feita por sum.
somaDiagonalPrincipal xs = sum $ map head $ zipWith drop [0..]  xs

matriz = [[ 1,2, 3, 4],[ 5, 6, 7, 8],[ 9,10,11,12], [13,14,15,16]]

main = do
    print(somaDiagonalPrincipal matriz)
