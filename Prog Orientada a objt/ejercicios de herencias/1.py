
class Animal:
    def hablar(self):
        print("Este animal hace un sonido.")

class Perro(Animal):
    def hablar(self):
        print("¡Guau!")

class Gato(Animal):
    def hablar(self):
        print("¡Miau!")


mi_animal_generico = Animal()
mi_perro = Perro()
mi_gato = Gato()

print("Animal genérico:")
mi_animal_generico.hablar()

print("\nPerro:")
mi_perro.hablar()

print("\nGato:")
mi_gato.hablar()