#include <iostream>
#include <vector>
#include <string>
#include <ctime>
#include <iomanip> // Para dar formato de tabla (setw)
#include <algorithm> // Para buscar en vectores (find)

using namespace std;

// Lista de direcciones IP restringidas
vector<string> lista_bloqueadas = {"192.168.1.100", "10.0.0.5"};

// Estructura para representar un registro (fila del DataFrame en Python)
struct RegistroPaquete {
    string ip_origen;
    string puerto; // String para facilitar la entrada, podría ser int
    string protocolo;
    string hora;
    string estado;
};

// Vector para almacenar la información de tráfico
vector<RegistroPaquete> registro_paquetes;

// -----------------------------
// FUNCIONES AUXILIARES
// -----------------------------

// Función para obtener la fecha y hora actual como string
string obtener_hora_actual() {
    time_t now = time(0);
    tm *ltm = localtime(&now);
    char buffer[20];
    // Formato: YYYY-MM-DD HH:MM:SS
    strftime(buffer, 20, "%Y-%m-%d %H:%M:%S", ltm);
    return string(buffer);
}

void generar_alerta(string ip, string puerto, string protocolo) {
    cout << "⚠️  ALERTA: Bloqueo de " << ip << " en puerto " << puerto 
         << " usando " << protocolo << "." << endl;
}

// -----------------------------
// FUNCIONES PRINCIPALES
// -----------------------------

void procesar_paquete(string ip_origen, string puerto_origen, string tipo_protocolo) {
    string momento = obtener_hora_actual();
    string estado;

    // Verificar si la IP está en lista negra
    // std::find busca el elemento en el vector
    if (find(lista_bloqueadas.begin(), lista_bloqueadas.end(), ip_origen) != lista_bloqueadas.end()) {
        estado = "Bloqueado";
        generar_alerta(ip_origen, puerto_origen, tipo_protocolo);
    } else {
        estado = "Permitido";
    }

    // Guardar registro
    RegistroPaquete nuevo_registro = {ip_origen, puerto_origen, tipo_protocolo, momento, estado};
    registro_paquetes.push_back(nuevo_registro);

    cout << "📦 Paquete desde " << ip_origen << ":" << puerto_origen 
         << "/" << tipo_protocolo << " -> " << estado << endl;
}

void mostrar_registros() {
    if (registro_paquetes.empty()) {
        cout << "No se han recibido paquetes aún." << endl;
        return;
    }

    cout << "\n HISTORIAL DE PAQUETES:\n" << endl;
    
    // Encabezado de la tabla simulando Pandas
    cout << left << setw(15) << "IP Origen" 
         << setw(10) << "Puerto" 
         << setw(12) << "Protocolo" 
         << setw(22) << "Hora" 
         << setw(10) << "Estado" << endl;
    
    cout << string(70, '-') << endl;

    int total = 0;
    int bloqueados = 0;
    int permitidos = 0;

    for (const auto& reg : registro_paquetes) {
        cout << left << setw(15) << reg.ip_origen 
             << setw(10) << reg.puerto 
             << setw(12) << reg.protocolo 
             << setw(22) << reg.hora 
             << setw(10) << reg.estado << endl;
        
        total++;
        if (reg.estado == "Bloqueado") bloqueados++;
        else permitidos++;
    }

    cout << "\n RESUMEN:" << endl;
    cout << "  Total: " << total << endl;
    cout << "  Permitidos: " << permitidos << endl;
    cout << "  Bloqueados: " << bloqueados << endl;
}

void agregar_ip_bloqueada() {
    string ip_nueva;
    cout << "Ingrese la IP que desea bloquear: ";
    cin >> ip_nueva;

    // Verificar si ya existe
    if (find(lista_bloqueadas.begin(), lista_bloqueadas.end(), ip_nueva) == lista_bloqueadas.end()) {
        lista_bloqueadas.push_back(ip_nueva);
        cout << " IP " << ip_nueva << " agregada correctamente." << endl;
    } else {
        cout << "⚠️  Esa IP ya se encuentra bloqueada." << endl;
    }
}

void mostrar_lista_bloqueadas() {
    cout << "\n LISTA DE IPs BLOQUEADAS:" << endl;
    for (size_t i = 0; i < lista_bloqueadas.size(); ++i) {
        cout << (i + 1) << ". " << lista_bloqueadas[i] << endl;
    }
}

// -----------------------------
// MENÚ PRINCIPAL
// -----------------------------

void iniciar_simulador() {
    string opcion;
    while (true) {
        cout << "\n===== FIREWALL SIMULADOR (C++) =====" << endl;
        cout << "1. Registrar paquete entrante" << endl;
        cout << "2. Mostrar registros" << endl;
        cout << "3. Ver IPs bloqueadas" << endl;
        cout << "4. Agregar nueva IP bloqueada" << endl;
        cout << "5. Salir" << endl;
        cout << "Seleccione una opción: ";
        cin >> opcion;

        if (opcion == "1") {
            string ip, puerto, protocolo;
            cout << "Ingrese la IP de origen: ";
            cin >> ip;
            cout << "Ingrese el puerto: ";
            cin >> puerto;
            cout << "Ingrese el protocolo (TCP/UDP): ";
            cin >> protocolo;
            procesar_paquete(ip, puerto, protocolo);
        }
        else if (opcion == "2") {
            mostrar_registros();
        }
        else if (opcion == "3") {
            mostrar_lista_bloqueadas();
        }
        else if (opcion == "4") {
            agregar_ip_bloqueada();
        }
        else if (opcion == "5") {
            cout << "👋 Finalizando simulador de firewall." << endl;
            break;
        }
        else {
            cout << "❌ Opción no válida. Intente nuevamente." << endl;
        }
    }
}

int main() {
    // Configuración para admitir caracteres especiales en algunas consolas
    setlocale(LC_ALL, ""); 
    iniciar_simulador();
    return 0;
}