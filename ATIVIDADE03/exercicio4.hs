-- Exercício 04: Utilizando a lista anterior, calcule a soma dos números de Fibonacci pares dos valores que não excedem 4.000.000. 

-- takeWhile cria uma lista de outra lista até que a condicao seja falsa.
-- somaFib recebe elementos pares menores ou iguais a 4 milhoes.
-- Esses elementos sao gerados pela funcao geradora fibo.

somaFib :: Int
somaFib = sum [ x | x <- takeWhile (<= 4000000) (fibo 0 1), even x]
  where
    fibo a b = a:fibo b (a+b) 


main = do
    print (somaFib)
