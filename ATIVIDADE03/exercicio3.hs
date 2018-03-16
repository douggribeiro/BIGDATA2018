-- Exercício 03: Crie a lista de números de Fibonacci utilizando uma função geradora.

-- funcao geradora Fibonnaci
fibo a b = a:fibo b (a+b) 

-- obtem 20 primeiros numeros iniciando a lista em 0 e 1
x = take 20 (fibo 0 1) 

main = do
    print(x)
