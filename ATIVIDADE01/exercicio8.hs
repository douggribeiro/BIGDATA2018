-- Exercício 08: Crie uma lista de anos bissextos desde o ano 1 até o atual.

-- Ano bissexto deve ser divisivel por 400 ou divisivel por 4 e nao divisivel por 10
lista = [ a | a <- [1..2018], a `rem` 400 == 0 ||  a `rem` 4 == 0 && a `rem` 10 /= 0 ] 

main = do 
    print lista
