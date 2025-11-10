import datetime
import pandas as pd

# Lista de direcciones IP restringidas
lista_bloqueadas = ["192.168.1.100", "10.0.0.5"]

# Matriz para almacenar la información de tráfico
registro_paquetes = []

# -----------------------------
# FUNCIONES PRINCIPALES
# -----------------------------

def procesar_paquete(ip_origen, puerto_origen, tipo_protocolo):
    """Analiza y registra la llegada de un paquete."""
    momento = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Verificar si la IP está en lista negra
    if ip_origen in lista_bloqueadas:
        estado = "Bloqueado"
        generar_alerta(ip_origen, puerto_origen, tipo_protocolo)
    else:
        estado = "Permitido"

    # Guardar registro
    entrada = [ip_origen, puerto_origen, tipo_protocolo, momento, estado]
    registro_paquetes.append(entrada)

    print(f"📦 Paquete desde {ip_origen}:{puerto_origen}/{tipo_protocolo} -> {estado}")


def generar_alerta(ip_origen, puerto_origen, tipo_protocolo):
    """Muestra una alerta cuando se detecta un paquete bloqueado."""
    print(f"⚠️ ALERTA: Bloqueo de {ip_origen} en puerto {puerto_origen} usando {tipo_protocolo}.")


def mostrar_registros():
    """Despliega todos los paquetes procesados."""
    if not registro_paquetes:
        print("No se han recibido paquetes aún.")
        return

    df = pd.DataFrame(registro_paquetes, columns=["IP Origen", "Puerto", "Protocolo", "Hora", "Estado"])
    print("\n HISTORIAL DE PAQUETES:\n")
    print(df)

    total = len(df)
    bloqueados = len(df[df["Estado"] == "Bloqueado"])
    permitidos = len(df[df["Estado"] == "Permitido"])

    print("\n RESUMEN:")
    print(f"  Total: {total}")
    print(f"  Permitidos: {permitidos}")
    print(f"  Bloqueados: {bloqueados}")


def agregar_ip_bloqueada():
    """Agrega una nueva IP a la lista de bloqueo."""
    ip_nueva = input("Ingrese la IP que desea bloquear: ")
    if ip_nueva not in lista_bloqueadas:
        lista_bloqueadas.append(ip_nueva)
        print(f" IP {ip_nueva} agregada correctamente.")
    else:
        print("⚠️ Esa IP ya se encuentra bloqueada.")


def mostrar_lista_bloqueadas():
    """Muestra todas las IPs restringidas."""
    print("\n LISTA DE IPs BLOQUEADAS:")
    for idx, ip in enumerate(lista_bloqueadas, 1):
        print(f"{idx}. {ip}")


# -----------------------------
# MENÚ PRINCIPAL
# -----------------------------
def iniciar_simulador():
    while True:
        print("\n===== FIREWALL SIMULADOR =====")
        print("1. Registrar paquete entrante")
        print("2. Mostrar registros")
        print("3. Ver IPs bloqueadas")
        print("4. Agregar nueva IP bloqueada")
        print("5. Salir")
        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            ip = input("Ingrese la IP de origen: ")
            puerto = input("Ingrese el puerto: ")
            protocolo = input("Ingrese el protocolo (TCP/UDP): ")
            procesar_paquete(ip, puerto, protocolo)

        elif opcion == "2":
            mostrar_registros()

        elif opcion == "3":
            mostrar_lista_bloqueadas()

        elif opcion == "4":
            agregar_ip_bloqueada()

        elif opcion == "5":
            print("👋 Finalizando simulador de firewall.")
            break

        else:
            print("❌ Opción no válida. Intente nuevamente.")


# -----------------------------
# EJECUCIÓN PRINCIPAL
# -----------------------------
if __name__ == "__main__":
    iniciar_simulador()
