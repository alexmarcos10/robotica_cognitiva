# Ejercicio 1: Revisa y transcribe el ejemplo básico describiendo cada uno de los elementos principales con tus palabras.

En primer lugar, voy a probar la demo, desde la ubicacion ros2_ws, ejecutamos la linea de comandos:

``` 
ros2 run yasmin_demo yasmin_demo.py
```
 
En una nueva terminal, ejecutamos la linea de comandos:
```
ros2 run yasmin_viewer yasmin_viewer_node

```

Una vez hecho esto, en el navegador, entramos en http://localhost:5000/
De esta forma logramos la visualización del ejemplo:

![1](https://github.com/alexmarcos10/robotica_cognitiva/assets/61562132/180aa819-c6b8-42f5-82bc-b909a5df50d4)

El ejemplo básico es tal que así:

![2](https://github.com/alexmarcos10/robotica_cognitiva/assets/61562132/887095af-0e06-4f93-9cd1-de2dc1dbc1d9)

El código sirve para implementar una máquina de estados utilizando la biblioteca Yasmin.

Paso 1: Se importan las librerias necesarias:

time: funciones relacionadas con el timepo

rclpy: libreria para trabajar con ros en python

Node: para crear nodos

State: representa estados de la maquina de estados

Blackboard: espacio de memoria comun

StateMachine:maquina de estados como tal

YasminViewerPub: visualización de la maquina de estados (como se muestra en la primera imagen)


Se definen dos estados, el primero Foostate, que tiene dos posibles resultados, outcome1 y outcome2. Se define el metodo execute que imprime "Executinng state FOO" e introduce una pausa de 3 segundos y se actualiza el contador (variable foo_str) en blackboard. SI el contador es menor de 3 devuelve outcome1, si el contador es igual o mayor que 3 devuelve outcome2.

El segundo estado es BARstate, solo tiene un posible resultado, outcome3 y su metodo execute imprime el mensaje "executing state BAR"e imprime la cadena almacenada en el blackboard (contador).

Después se crea la maquina de estados llamada sm y se añaden los estados FOO y BAR así como sus transiciones.
La transición de FOO a BAR ocurre cuando el resultado es outcome1.
La transición de FOO a outcome 4 ocurre cuando el resultado es outcome2.
La transición de BAR a FOO ocurre cuando el resultado es outcome3.

EL funcionamiento por tanto es, empieza en FOO, como el contador es menor que 3, la salida es outcome1 y da lugar a la transición FOO-BAR. 
BAR solo tiene el resultado outcome3 por tanto hace la transición de BAR a FOO. Este paso se repite hasta que el contador es igual a 3. EN este caso la salida de FOO es outcome2, por tanto ocurre una transición de FOO a outcome4.

![3](https://github.com/alexmarcos10/robotica_cognitiva/assets/61562132/33018ae0-6756-4912-85ba-473223b5acbe)


Se crea una instancia del visualizador con el nombre "YASMIN_DEMO" y se ejecuta e imprime el resultado de la maquina de estados.

# Ejercicio 2: Modifica el ejemplo anterior para que tenga un estado más.

He añadido el estado Extra: 

# define state Extra
class Extrastate(State):
    def __init__(self) -> None:
        super().__init__(outcomes=["outcome5"])

    def execute(self, blackboard: Blackboard) -> str:
        print("Executing state Extra")
        time.sleep(3)
 
        return "outcome5"
        
        
Este estado tiene como resultado outcome5


En la maquina de estados, he realizado una modificacion en las transiciones:

# add states
        sm.add_state("FOO", FooState(),
                     transitions={"outcome1": "BAR",
                                  "outcome2": "EXTRA"})
        sm.add_state("BAR", BarState(),
                     transitions={"outcome3": "FOO"})
        
        sm.add_state("EXTRA", Extrastate(),
                     transitions={"outcome5": "outcome4"})
                     
                     
                     
De esta forma, cuando el resultado es outcome2, la transición de FOO es al estado EXTRA
CUando el resultado es outcome5 (estado EXTRA) realiza una transición a OUTCOME4.


![4](https://github.com/alexmarcos10/robotica_cognitiva/assets/61562132/1d85015c-e940-4d3d-b8ad-b865c1b21f1a)


![5](https://github.com/alexmarcos10/robotica_cognitiva/assets/61562132/76812775-2a69-48d2-8c99-d1b7c0bc3378)


#Ejercicio 3: Define que es un Blackboard, para qué se utiliza en YASMIN. Indica puntos positivos y negativos.

Blackboard es un mecanismo que permite compartir datos entre los estados de las maquinas de estado, es un espacio de almacenamiento compartido en el que los estados pueden leer y escribir informacion. EN el ejemplo anterior, vimos como el estado Foo Y Bar compartian informacion mediante el blackboard del contador.
Los puntos positivos es que permite la comunicacion de una manera coordinada y puede escalarse a multiples estados.
, 
Los puntos negativos es que pued ellegar un punto en el que sea complejo poder gestionar y que haya una sincronizacion que no se ajuste bien al problema requerido.

# EJercicio 4: Modifica el ejemplo anterior para que cada estado publique un mensaje diferente sobre un topic de tu elección.

Para este ejercicio se ha realizado la siguiente modificacion:
Tanto en la clase FooState, como Barstate, como Extrastate, en la funcion de inicializacion se define un publisher para poder publicar mensajes : def __init__(self, publisher) -> None:
y despues definimos publisher como un atributo de la clase:  self.publisher = publisher
EN la función execute se crea el mensaje de tipo string, se asigna un mensaje al atributo data y se publica el mensaje en el topic, de esta forma, el codigo modificado para cada estado seria:

![7](https://github.com/alexmarcos10/robotica_cognitiva/assets/61562132/47ea65d3-e93c-409c-98a5-ea437f5889f7)


En la clase DemoNode, se crea el publisher en el topic pubmsgs y cuando se añaden los estados hay que pasar como argumento el publisher, quedando el codigo tal que asi:

![8](https://github.com/alexmarcos10/robotica_cognitiva/assets/61562132/087ff526-b73f-4296-9082-81a5f9d29dd5)


UNa vez hecho esto, si ejecutamos la demo, cada vez que se ejecuta un estado, se esta publicando en el topico pubmsgs un mensaje con el estado que se ejecuta. POdemos visualizarlo tanto mostrando el contenido del topico pubmsgs como con rqt_graph, donde aparte del topico del visualizador, aparece el topico pubmsgs




![6](https://github.com/alexmarcos10/robotica_cognitiva/assets/61562132/8e7d6723-f54a-49e6-bec7-4e608e96358a)


