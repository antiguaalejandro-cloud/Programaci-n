# 3️⃣ Factorial de un número
print("\n3. Factorial de un número:")
n = int(input("Ingresa un número entero: "))
factorial = 1
for i in range(1, n + 1):
    factorial *= i
print(f"El factorial de {n} es {factorial}")

