# Pregunta 1
> En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código, por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?

El código que estaba repetido entre los tests 01 y 02 correspondía a tomar el tiempo que tardaba en evaluarse ciertas líneas de código, y la abstracción naturalmente fue crear un método que recibiera un bloque de código y devolviera el tiempo que tardaba en ejecutarse.
En nuestro caso, más que modelar un ente nuevo de la realidad, lo que hace esta abstracción es darle al _tester_ la capacidad de responder algo que debería saber: _cuánto tardó realizar esta tarea?_ Entonces, en sí no representa algo nuevo del dominio del problema, sino que hace que el tester se adecúe más a las necesidades del problema.

# Pregunta 2
> ¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para representar entidades de la realidad?

La principal manera, por la que más se conoce a Smalltalk y otros lenguajes parecidos, es un **Objeto**. Un objeto se define por los mensajes que sabe responder. Representan entes de la vida real, y los mensajes que responden los objetos representan cosas acerca de esos entes: que acciones pueden realizar, como interaccionan con otros objetos, etc.
CuisUniversity nos da la oportunidad de utilizar los objetos de 2 formas. La primera es con los *DenotativeObject*, que son objetos prototipo, y representan entes concretos de la realidad (como 'el Semáforo de Maipú y Corrientes'). La otra forma (que es la forma estándar de programar en Smalltalk) es con *Clases*, que representan conceptos o categorías, y a partir de las cuales podemos modelar objetos que tengan aspectos en común (como el concepto de 'Semáforo').
También podemos utilizar los métodos y colaboradores internos de un objeto para representar 'entes' de la realidad que en verdad sean parte de o estén subordinados a otros entes. Por ejemplo, en este ejercicio modelamos un libro de clientes con un objeto, y los clientes del libro con una lista de *strings* que almacena el libro. Si bien la lista y los strings son sus propios objetos, en este caso actúan más como una parte del libro de clientes.

# Pregunta 3
> ¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?

Naur proponía que los programadores deben construir una teoría sobre el problema que están encarando, y que construir mejores sistemas requería construír mejores teorías. Las abstracciones nos permiten ponerle nombre a ciertos aspectos del problema y de su implementación, y eso nos permite estudiar mejor esos aspectos para profundizar en la teoría del programa. Mediante las abstracciones podemos identificar las distintas partes del sistema y cómo se relacionan entre ellas, y estudiando eso podemos mejorar nuestra teoría y por lo tanto mejorar nuestro programa y escribir código más mantenible y entendible.