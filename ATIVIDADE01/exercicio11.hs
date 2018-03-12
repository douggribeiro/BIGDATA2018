-- Exercício 11: Crie um concatenador de strings que concatena duas 
-- strings separadas por espaço.


str = "Universidade Federal"

concatenador :: String -> String
concatenador str = filter (/= ' ') str

main = do
    print (concatenador(str))
