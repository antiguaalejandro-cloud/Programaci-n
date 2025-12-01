import tkinter as tk

last_x, last_y = None, None

def iniciar_dibujo(event):
    global last_x, last_y
    last_x, last_y = event.x, event.y

def dibujar(event):
    global last_x, last_y
    lienzo.create_line(last_x, last_y, event.x, event.y, 
                       width=3, fill="black", capstyle=tk.ROUND, smooth=True)
    
    last_x, last_y = event.x, event.y

ventana = tk.Tk()
ventana.title("Ejercicio 5: Pizarra de Dibujo")

lienzo = tk.Canvas(ventana, width=500, height=400, bg="white", cursor="pencil")
lienzo.pack()

tk.Label(ventana, text="Mantén presionado el clic izquierdo para dibujar").pack()

lienzo.bind("<Button-1>", iniciar_dibujo)
lienzo.bind("<B1-Motion>", dibujar)

ventana.mainloop()