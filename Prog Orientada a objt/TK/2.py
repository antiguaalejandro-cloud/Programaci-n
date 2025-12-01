import tkinter as tk

def mostrar_texto():
    texto = entrada.get()
    etiqueta_resultado.config(text=f"Escribiste: {texto}")

ventana = tk.Tk()
ventana.title("Ejercicio 2: Espejo")
ventana.geometry("300x200")

entrada = tk.Entry(ventana, width=30)
entrada.pack(pady=10)

boton = tk.Button(ventana, text="Mostrar Texto", command=mostrar_texto)
boton.pack(pady=5)

etiqueta_resultado = tk.Label(ventana, text="Aquí aparecerá tu texto", fg="blue")
etiqueta_resultado.pack(pady=20)

ventana.mainloop()