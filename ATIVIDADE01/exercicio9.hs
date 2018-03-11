-- Encontre os 10 primeiros anos bissextos.

lista = [ a | a <- [1..2018], a `rem` 400 == 0 ||  a `rem` 4 == 0 && a `rem` 10 /= 0 ] 
lista10 = take 10 lista

main = do 
    print (take 10 lista) --ou
    print(lista10)

-- [4,8,12,16,24,28,32,36,44,48]
-- [4,8,12,16,24,28,32,36,44,48]

