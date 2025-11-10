# Ejercicio 1: Tuplas
print("=== EJERCICIO 1: TUPLAS ===")

# Crear la tupla
vulnerabilidades = ('SQL Injection', 'Cross-Site Scripting', 'Buffer Overflow', 'Denegación de Servicio')

# a) Mostrar el segundo elemento de la tupla
print("a) Segundo elemento:", vulnerabilidades[1])

# b) Mostrar los dos últimos elementos
print("b) Dos últimos elementos:", vulnerabilidades[-2:])

# c) Intentar modificar un elemento (esto generará un error)
try:
    vulnerabilidades[0] = 'Nueva vulnerabilidad'
except TypeError as e:
    print("c) Error al intentar modificar:", e)