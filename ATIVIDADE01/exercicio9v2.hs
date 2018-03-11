-- Exercício 09: Encontre os 10 últimos anos bissextos 
-- (dica: use a função length para determinar o tamanho da lista).

lista = [ a | a <- [1..2018], a `rem` 400 == 0 ||  a `rem` 4 == 0 && a `rem` 10 /= 0 ] 
tamanho = length lista - 10


main = do
    let (ys,zs) = splitAt tamanho lista
    print (zs)

