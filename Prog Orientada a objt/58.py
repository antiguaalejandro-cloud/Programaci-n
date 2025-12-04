import tkinter as tk

class Aplicacion:
    def __init__(self):
        self.valor=1
        self.ventana1=tk.Tk()
        self.ventana1.title("contador y button")
        self.label1=tk.Label(self.ventana1, text=self.valor)
        self.label1.grid(column=0, row=0)
        self.label1.configure(foreground="red")
        
        self.boton1=tk.Button(self.ventana1, text="Aumentar", command=self.aumentar)
        self.boton1.grid(column=0, row=1)
        
        self.boton2=tk.Button(self.ventana1, text="Disminuir", command=self.disminuir)
        self.boton2.grid(column=1, row=1)
        
        self.ventana1.mainloop()
        
    def aumentar(self):
        self.valor += 1
        self.label1.configure(text=self.valor)
        
    def disminuir(self):
        self.valor -= 1
        self.label1.configure(text=self.valor)
        
aplicacion1=Aplicacion()