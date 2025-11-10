# Ejercicio 2: Listas
print("\n=== EJERCICIO 2: LISTAS ===")

# Crear la lista
puertos_abiertos = [22, 80, 443, 8080]
print("Lista original:", puertos_abiertos)

# a) Agregar el puerto 21 a la lista
puertos_abiertos.append(21)
print("a) Después de agregar puerto 21:", puertos_abiertos)

# b) Eliminar el puerto 8080
puertos_abiertos.remove(8080)
print("b) Después de eliminar puerto 8080:", puertos_abiertos)

# c) Mostrar la lista ordenada de menor a mayor
puertos_abiertos.sort()
print("c) Lista ordenada:", puertos_abiertos)