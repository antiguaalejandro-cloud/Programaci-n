#include <iostream>
using namespace std;

int main() {
    int numero, pares = 0, impares = 0;

    cout << "Ingrese 10 números:" << endl;
    for (int i = 0; i < 10; i++) {
        cin >> numero;
        if (numero % 2 == 0)
            pares++;
        else
            impares++;
    }

    cout << "Cantidad de números pares: " << pares << endl;
    cout << "Cantidad de números impares: " << impares << endl;

    return 0;
}