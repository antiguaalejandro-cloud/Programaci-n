import math

class Figura:
    def area(self):
        pass

class Circulo(Figura):
    def __init__(self, radio):
        self.radio = radio

    def area(self):
        return math.pi * (self.radio ** 2)

class Cuadrado(Figura):
    def __init__(self, lado):
        self.lado = lado

    def area(self):
        return self.lado * self.lado


mi_circulo = Circulo(5)      
mi_cuadrado = Cuadrado(4)    

print(f"Área del Círculo (radio {mi_circulo.radio}): {mi_circulo.area():.2f}")
print(f"Área del Cuadrado (lado {mi_cuadrado.lado}): {mi_cuadrado.area()}")