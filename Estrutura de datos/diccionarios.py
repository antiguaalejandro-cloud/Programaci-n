# Ejercicio 3: Diccionarios
print("\n=== EJERCICIO 3: DICCIONARIOS ===")

# Crear el diccionario
dispositivo_red = {
    'IP': '192.168.1.10',
    'Hostname': 'Firewall-Corp',
    'Estado': 'Activo'
}
print("Diccionario original:", dispositivo_red)

# a) Mostrar el valor de la clave 'Hostname'
print("a) Hostname:", dispositivo_red['Hostname'])

# b) Agregar una nueva clave llamada 'Ubicación' con el valor 'Centro de Datos'
dispositivo_red['Ubicación'] = 'Centro de Datos'
print("b) Después de agregar Ubicación:", dispositivo_red)

# c) Cambiar el valor de 'Estado' a 'Inactivo'
dispositivo_red['Estado'] = 'Inactivo'
print("c) Después de cambiar Estado:", dispositivo_red)

# d) Mostrar todo el diccionario actualizado
print("d) Diccionario actualizado completo:")
for clave, valor in dispositivo_red.items():
    print(f"   {clave}: {valor}")