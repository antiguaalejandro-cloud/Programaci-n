Algoritmo ControlAccesosWiFi
    Definir dispositivosAutorizados, registrosConexion, contadorConexiones Como Cadena
    Definir maxConexiones, opcion, i, j, contador Como Entero
    Definir mac, ip, buscarMAC, buscarIP Como Cadena
    Definir accesoAutorizado Como Logico
    
    Dimension dispositivosAutorizados[100, 3]  
    Dimension registrosConexion[100, 3]        
    Dimension contadorConexiones[100, 2]       
    
    maxConexiones <- 3  
    
    
    dispositivosAutorizados[1,1] <- "AA:BB:CC:DD:EE:01"
    dispositivosAutorizados[1,2] <- "192.168.1.10"
    dispositivosAutorizados[1,3] <- "AUTORIZADO"
    
    dispositivosAutorizados[2,1] <- "AA:BB:CC:DD:EE:02"
    dispositivosAutorizados[2,2] <- "192.168.1.11"
    dispositivosAutorizados[2,3] <- "AUTORIZADO"
    
    contador <- 2  
    
    Escribir "=== SISTEMA DE CONTROL DE ACCESOS WiFi ==="
    
    Repetir
        Escribir ""
        Escribir "1. Registrar nuevo dispositivo"
        Escribir "2. Intentar conexión"
        Escribir "3. Mostrar dispositivos autorizados"
        Escribir "4. Mostrar registros de conexión"
        Escribir "5. Buscar dispositivo por MAC"
        Escribir "6. Generar reporte de seguridad"
        Escribir "0. Salir"
        Escribir "Seleccione una opción: "
        Leer opcion
        
        Segun opcion Hacer
            1:  
                Escribir "=== REGISTRAR NUEVO DISPOSITIVO ==="
                Escribir "Ingrese dirección MAC (formato XX:XX:XX:XX:XX:XX): "
                Leer mac
                Escribir "Ingrese dirección IP: "
                Leer ip
                
			
                accesoAutorizado <- Falso
                Para i <- 1 Hasta contador Hacer
                    Si dispositivosAutorizados[i,1] = mac Entonces
                        accesoAutorizado <- Verdadero
                        Escribir "Error: La MAC ya está registrada"
                        i <- contador  
                    FinSi
                FinPara
                
                Si NO accesoAutorizado Entonces
                    contador <- contador + 1
                    dispositivosAutorizados[contador,1] <- mac
                    dispositivosAutorizados[contador,2] <- ip
                    dispositivosAutorizados[contador,3] <- "AUTORIZADO"
                    Escribir "Dispositivo registrado exitosamente!"
                FinSi
                
            2:  
                Escribir "=== INTENTO DE CONEXIÓN ==="
                Escribir "Ingrese dirección MAC del dispositivo: "
                Leer buscarMAC
                Escribir "Ingrese dirección IP del dispositivo: "
                Leer buscarIP
                
                accesoAutorizado <- Falso
                Para i <- 1 Hasta contador Hacer
                    Si dispositivosAutorizados[i,1] = buscarMAC Y dispositivosAutorizados[i,3] = "AUTORIZADO" Entonces
                        accesoAutorizado <- Verdadero
                        
					
                        Sino
                            Escribir "ALERTA: Límite de conexiones alcanzado para MAC: ", buscarMAC
                        FinSi
                        i <- contador  
                    
                FinPara
                
                Si NO accesoAutorizado Entonces
                    Escribir "ALERTA DE SEGURIDAD: Acceso NO AUTORIZADO detectado!"
                    Escribir "MAC: ", buscarMAC, " - IP: ", buscarIP
                  
                FinSi
                
            3:  
                Escribir "=== DISPOSITIVOS AUTORIZADOS ==="
                Escribir "No. | MAC Address | IP Address | Estado"
                Escribir "----------------------------------------"
                Para i <- 1 Hasta contador Hacer
                    Si dispositivosAutorizados[i,1] <> "" Entonces
                        Escribir i, " | ", dispositivosAutorizados[i,1], " | ", dispositivosAutorizados[i,2], " | ", dispositivosAutorizados[i,3]
                    FinSi
                FinPara
                
            4:  
                Escribir "=== REGISTROS DE CONEXIÓN ==="
                Escribir "MAC Address | IP Address | Tipo de Evento"
                Escribir "----------------------------------------"
                Para i <- 1 Hasta 100 Hacer
                    Si registrosConexion[i,1] <> "" Entonces
                        Escribir registrosConexion[i,1], " | ", registrosConexion[i,2], " | ", registrosConexion[i,3]
                    FinSi
                FinPara
                
            5:  
                Escribir "=== BUSCAR DISPOSITIVO ==="
                Escribir "Ingrese dirección MAC a buscar: "
                Leer buscarMAC
                
                accesoAutorizado <- Falso
                Para i <- 1 Hasta contador Hacer
                    Si dispositivosAutorizados[i,1] = buscarMAC Entonces
                        Escribir "Dispositivo encontrado:"
                        Escribir "MAC: ", dispositivosAutorizados[i,1]
                        Escribir "IP: ", dispositivosAutorizados[i,2]
                        Escribir "Estado: ", dispositivosAutorizados[i,3]
                      
                        accesoAutorizado <- Verdadero
                        i <- contador  
                    FinSi
                FinPara
                
                Si NO accesoAutorizado Entonces
                    Escribir "Dispositivo no encontrado en la lista de autorizados"
                FinSi
                
		
                
            0:
                Escribir "Saliendo del sistema..."
            De Otro Modo:
                Escribir "Opción no válida"
        FinSegun
        
    Hasta Que opcion = 0
    
FinAlgoritmo

