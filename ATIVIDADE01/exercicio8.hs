-- Exercício 08: Crie uma lista de anos bissextos desde o ano 1 até o atual.

lista = [ a | a <- [1..2018], a `rem` 400 == 0 ||  a `rem` 4 == 0 && a `rem` 10 /= 0 ] 

main = do 
    print lista
