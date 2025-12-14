#include <iostream>
using namespace std;

int main() {
    float celsius;
    cout << "Ingrese la temperatura en grados Celsius: ";
    cin >> celsius;

    float fahrenheit = (celsius * 9.0 / 5.0) + 32;
    cout << celsius << " °C equivalen a " << fahrenheit << " °F" << endl;

    return 0;
}