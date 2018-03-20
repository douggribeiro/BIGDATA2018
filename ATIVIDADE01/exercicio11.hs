-- Exercício 11: Crie um concatenador de strings que concatena duas 
-- strings separadas por espaço.


str = "Universidade Federal"

concatenador :: String -> String -> String
concatenador str1 str2 = str1 ++ " " ++ str2

main = do
    print (concatenador "Universidade" "Federal")
