#include <iostream>
#include <string>
using namespace std;

struct Estudiante {
    string nombre;
    int edad;
    float promedio;
};

int main() {
    Estudiante estudiantes[3];
    float mejorPromedio = 0;
    string mejorEstudiante;

    for (int i = 0; i < 3; i++) {
        cout << "\nEstudiante " << i + 1 << ":" << endl;
        cout << "Nombre: ";
        cin.ignore();
        getline(cin, estudiantes[i].nombre);
        cout << "Edad: ";
        cin >> estudiantes[i].edad;
        cout << "Promedio: ";
        cin >> estudiantes[i].promedio;

        if (estudiantes[i].promedio > mejorPromedio) {
            mejorPromedio = estudiantes[i].promedio;
            mejorEstudiante = estudiantes[i].nombre;
        }
    }

    cout << "\nEl mejor promedio es de " << mejorEstudiante 
         << " con " << mejorPromedio << endl;

    return 0;
}