function fibonacci_of(x)
    if x == 1 || x == 0
        x
    else
        fibonacci_of(x - 1) + fibonacci_of(x - 2)
    end
end

println("Enter a numnber: ")
num = readline()
numero = parse(Int, num)

while numero <= 0
    println("Please, choose another number: ")
    global numero = readline()
end

println("Fibonacci number: $(@time fibonacci_of(numero))")
