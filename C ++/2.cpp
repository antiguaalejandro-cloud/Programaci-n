#include <iostream>
#include <string>
using namespace std;

int main() {
    string nombre;
    int edad;
    float estatura;

    cout << "Nombre: ";
    getline(cin, nombre);
    cout << "Edad: ";
    cin >> edad;
    cout << "Estatura (m): ";
    cin >> estatura;

    cout << "\n=== Ficha Personal ===" << endl;
    cout << "Nombre: " << nombre << endl;
    cout << "Edad: " << edad << " años" << endl;
    cout << "Estatura: " << estatura << " m" << endl;

    return 0;
}