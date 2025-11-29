
# 3️⃣ Adivinar número secreto
print("\n3. Adivina el número secreto (entre 1 y 10):")
secreto = 7
intento = int(input("Adivina el número: "))
while intento != secreto:
    print("Incorrecto, intenta otra vez.")
    intento = int(input("Adivina el número: "))
print("¡Correcto! 🎉 El número era 7.")

