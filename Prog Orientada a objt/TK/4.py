import tkinter as tk

def agregar_item():
    nuevo_elemento = entrada.get()
    if nuevo_elemento:  
        lista.insert(tk.END, nuevo_elemento)  
        entrada.delete(0, tk.END)  

ventana = tk.Tk()
ventana.title("Ejercicio 4: Lista")
ventana.geometry("300x300")

frame_entrada = tk.Frame(ventana)
frame_entrada.pack(pady=10)

entrada = tk.Entry(frame_entrada, width=20)
entrada.pack(side=tk.LEFT, padx=5)

boton = tk.Button(frame_entrada, text="Agregar", command=agregar_item)
boton.pack(side=tk.LEFT)

lista = tk.Listbox(ventana, width=40, height=10)
lista.pack(pady=10, padx=10)

ventana.mainloop()