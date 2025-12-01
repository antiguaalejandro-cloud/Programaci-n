class Empleado:
    def __init__(self, nombre, salario):
        self.nombre = nombre
        self.salario = salario

    def calcular_bono(self):
        return 0

class Gerente(Empleado):
    def calcular_bono(self):
        return self.salario * 0.20

class Tecnico(Empleado):
    def calcular_bono(self):
        return self.salario * 0.10


empleado_gerente = Gerente("Carlos", 5000)
empleado_tecnico = Tecnico("Ana", 3000)

print(f"Empleado: {empleado_gerente.nombre} (Gerente)")
print(f"Salario base: ${empleado_gerente.salario}")
print(f"Bono a recibir: ${empleado_gerente.calcular_bono()}")

print("-" * 30)

print(f"Empleado: {empleado_tecnico.nombre} (Técnico)")
print(f"Salario base: ${empleado_tecnico.salario}")
print(f"Bono a recibir: ${empleado_tecnico.calcular_bono()}")