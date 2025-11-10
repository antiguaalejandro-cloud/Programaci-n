import datetime

ahora = datetime.datetime.now()
print("Fecha y hora actual:", ahora)

fecha_especifica = datetime.datetime(2023, 1, 1, 12, 0, 0)
print("Fecha y hora específica:", fecha_especifica.strptime("2023-01-01 12:00:00", "%Y-%m-%d %H:%M:%S"))

