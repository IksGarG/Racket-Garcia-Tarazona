# Calculadora de suma de números primos en Elixir

- Andres Tarazona Solloa
- Iker Garcia German

## Introducción

Este programa en Elixir está diseñado para calcular la suma de números primos dentro de un rango específico, y demostrar la eficacia del procesamiento paralelo al comparar el tiempo de ejecución entre secuencial y paralelo.

## Funciones Principales

Las principales funciones en este código son:

1. `is_prime(num)`: Determina si un número es primo. Utiliza una técnica matemática para reducir el número de verificaciones realizadas.

2. `range_sum({start, finish})`: Suma todos los números primos en un rango definido por los parámetros de inicio y fin.

3. `make_ranges(start, finish, cores)`: Crea rangos igualmente espaciados para el número de cores proporcionados. Esto se utiliza para distribuir el trabajo entre los diferentes cores disponibles en el sistema.

4. `total_sum(start, finish, cores)`: Utiliza el procesamiento paralelo para calcular la suma total de los números primos en el rango especificado.

5. `sequential_prime_sum()`: Calcula la suma de números primos de forma secuencial y muestra el tiempo de ejecución y el resultado.

6. `parallel_prime_sum(cores)`: Calcula la suma de números primos de forma paralela y muestra el tiempo de ejecución y el resultado para el número de cores proporcionado.

7. `speedup`: Calcula y muestra la aceleración obtenida por el cálculo paralelo comparado con el cálculo secuencial.

## System.schedulers_online()

`System.schedulers_online()` es una función en Elixir que devuelve el número de planificadores de tareas disponibles para ejecutar en paralelo. En el contexto de Elixir, un planificador es un ente que se encarga de la ejecución de los procesos.

En el código, se utiliza `System.schedulers_online()` para determinar el número de núcleos disponibles en la máquina que ejecuta el código. Esto permite al programa utilizar de forma óptima los recursos de la máquina, dividiendo el trabajo entre los núcleos disponibles.

## Análisis de tiempo y speedup

El tiempo secuencial y paralelo se miden utilizando la función `:timer.tc()`, que devuelve el tiempo en microsegundos. En el ejemplo proporcionado, la versión secuencial tomó 2979 milisegundos, mientras que la versión paralela con 16 cores tomó solo 520 milisegundos.

El speedup se calcula dividiendo el tiempo secuencial entre el tiempo paralelo. En este caso, el speedup es de aproximadamente 5.73, lo que indica que la versión paralela fue casi 6 veces más rápida que la versión secuencial.

## Conclusión y Mejoras Potenciales

El código demuestra la efectividad de utilizar el procesamiento paralelo en Elixir para mejorar el rendimiento de las operaciones intensivas en CPU. Sin embargo, el grado de mejora variará dependiendo del número de cores disponibles en la máquina.

Una mejora potencial al código podría ser implementar un control de errores más robusto, por ejemplo, verificando que los valores de inicio y fin sean válidos antes de calcular las sumas. Además, podría optimizarse el algoritmo de detección de números primos para mejorar aún más el rendimiento.