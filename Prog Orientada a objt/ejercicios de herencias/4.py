class Vehiculo:
    def mover(self):
        print("El vehículo se está desplazando.")

class Carro(Vehiculo):
    def mover(self):
        print("El carro avanza usando su motor y 4 ruedas.")


class Bicicleta(Vehiculo):
    def mover(self):
        print("La bicicleta avanza al pedalear.")

mi_carro = Carro()
mi_bici = Bicicleta()

print("--- Ejercicio 4 ---")
mi_carro.mover()
mi_bici.mover()