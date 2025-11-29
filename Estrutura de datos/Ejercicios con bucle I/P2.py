# 2️⃣ Sumar números hasta que el usuario escriba 0
print("\n2. Suma de números hasta que escribas 0:")
suma = 0
num = float(input("Ingresa un número (0 para terminar): "))
while num != 0:
    suma += num
    num = float(input("Ingresa otro número (0 para terminar): "))
print("La suma total es:", suma)
