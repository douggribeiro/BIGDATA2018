-- Exercício 12: Dada a string “0123456789”, crie uma lista com os dígitos 
-- em formato Integer.


str = "0123456789"
toString a = [ read [x] :: Int | x<- a ]

main = do
    print(toString(str))
