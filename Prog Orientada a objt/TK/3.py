import tkinter as tk
from tkinter import messagebox

def sumar():
    try:
        num1 = float(entrada1.get())
        num2 = float(entrada2.get())
        resultado = num1 + num2
        etiqueta_resultado.config(text=f"Resultado: {resultado}")
    except ValueError:
        messagebox.showerror("Error", "Por favor ingresa solo números válidos")

ventana = tk.Tk()
ventana.title("Ejercicio 3: Sumadora")
ventana.geometry("300x250")

tk.Label(ventana, text="Número 1:").pack(pady=5)
entrada1 = tk.Entry(ventana)
entrada1.pack()

tk.Label(ventana, text="Número 2:").pack(pady=5)
entrada2 = tk.Entry(ventana)
entrada2.pack()

boton_sumar = tk.Button(ventana, text="Sumar", command=sumar, bg="#dddddd")
boton_sumar.pack(pady=15)

etiqueta_resultado = tk.Label(ventana, text="Resultado: 0", font=("Arial", 12, "bold"))
etiqueta_resultado.pack()

ventana.mainloop()