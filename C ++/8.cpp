#include <iostream>
using namespace std;

int main() {
    int numero, suma = 0;

    cout << "Ingrese números (0 para terminar):" << endl;
    while (true) {
        cin >> numero;
        if (numero == 0) break;
        suma += numero;
    }

    cout << "La suma total es: " << suma << endl;

    return 0;
}