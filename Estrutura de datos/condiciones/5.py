# 5️⃣ Descuento en compra
monto = float(input("\n5. Ingresa el monto de la compra: "))
if monto > 500:
    descuento = monto * 0.10
    total = monto - descuento
    print(f"Se aplicó un 10% de descuento. Total a pagar: {total:.2f}")
else:
    print(f"Total a pagar: {monto:.2f}")