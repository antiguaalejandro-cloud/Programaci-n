# 5️⃣ Promedio de 5 notas
print("\n\n5. Promedio de 5 notas:")
suma_notas = 0
for i in range(5):
    nota = float(input(f"Ingrese la nota {i+1}: "))
    suma_notas += nota
promedio = suma_notas / 5
print(f"Promedio final: {promedio:.2f}")
