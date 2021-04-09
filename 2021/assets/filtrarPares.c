#include <stdio.h>
int esPar(int); // te aviso que esto va a estar, tranquilo (al compilador se lo digo)
void filtrarPares(int[], int, int[]);

// Para probar:
// compilar
// hacer un main
// llamar a la función con parámetros
// imprimir los resultados
// verificar que lo que se imprime es lo que yo quiero
void main(){
  int nros[10] = {1,2,3,4,5,6,7,8,9,10};
  int respuesta[10];
  filtrarPares(nros, 10, respuesta);
  for (int i=0; i <= 10; i++) {
    printf("%d\n", respuesta[i]);
  }
}


void filtrarPares(int numeros[], int limite, int pares[]){
  int i, j = 0;
  for (i = 0; i < limite; i++) {
    if (esPar(numeros[i])) {
      pares[j] = numeros[i];
      j++;
    }
  }
}

int esPar(int numero){
  return numero % 2 == 0;
}
// legibilidad acá le llamamos "expresividad"

// nombres verbos???