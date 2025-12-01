class Dispositivo:
    def encender(self):
        print("Encendiendo dispositivo genérico...")

class Laptop(Dispositivo):
    def encender(self):
        print("La Laptop está arrancando el sistema operativo.")

class Telefono(Dispositivo):
    def encender(self):
        print("El Teléfono ilumina la pantalla táctil y busca señal.")

mi_laptop = Laptop()
mi_telefono = Telefono()

print("\n--- Ejercicio 5 ---")
mi_laptop.encender()
mi_telefono.encender()