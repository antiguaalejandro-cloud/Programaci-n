#include <iostream>
using namespace std;

int main() {
    int num1, num2;
    cout << "Ingrese dos números enteros: ";
    cin >> num1 >> num2;

    cout << "Suma: " << num1 + num2 << endl;
    cout << "Resta: " << num1 - num2 << endl;
    cout << "Multiplicación: " << num1 * num2 << endl;
    if (num2 != 0)
        cout << "División: " << (float)num1 / num2 << endl;
    else
        cout << "División: No se puede dividir entre cero." << endl;

    return 0;
}