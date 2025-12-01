import tkinter as tk

ventana = tk.Tk()
ventana.title("Ejercicio 1: Bienvenida")
ventana.geometry("300x100")

etiqueta = tk.Label(ventana, text="¡Hola! Bienvenido a Rayner world", font=("Arial", 14))

etiqueta.pack(pady=30)

ventana.mainloop()