#include <iostream>
using namespace std;

int main() {
    float base, altura;
    cout << "Base del rectángulo: ";
    cin >> base;
    cout << "Altura del rectángulo: ";
    cin >> altura;

    float area = base * altura;
    cout << "El área del rectángulo es: " << area << endl;

    return 0;
}