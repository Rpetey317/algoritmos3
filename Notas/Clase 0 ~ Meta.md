# Clase 0 - Martes, 14 de marzo

## Meta - Intro a la materia:

**Sobre la materia:**

- Foco en lo técnico
- Busca sentar las bases del desarrollo en mediana y gran escala
- Object Oriented Programming (OOP) (Visión fundacional) y Test-Driven Development (TDD)
- Lenguaje - Smalltalk (Cuis)

**Programa de la materia:**

1. Introducción al desarrollo de Software
2. Introducción al paradigma fundacional de objetos (7/8 Clases)
3. Técnicas prácticas y heurísticas de diseño (7/8 Clases)

================Parcial 1 - 16/5================

4. TDD (3 Clases)
5. Modelado avanzado (5 Clases)

================Parcial 2 - 16/6================

**Fechas de parciales:** \

- 1° Parcial: Martes 16/5 18hrs
- 2°Parcial: Viernes 16/6 17hrs

**Cursada:** \

- 25 Clases - Teórico-prácticas
- 7 ejercicios en máquina (de a pares)
- 10 lecturas - Quizzes (4 quizzes >= 75\% = +0,5 en el 2° parcial)
- Nota del 2° parcial >= 4 = Aprobada la materia
- Promoción:
     - Nota 2° Parcial >= 7
     - Nota cursada (promedio entre 2° parcial y (Suma de nota de los ejercicios _ 0.7 + Nota del 1er parcial _ 0.3)) >= 7

### Introducción a Smalltalk:

**Breve historia de Smalltalk:**

_En anteriores episodios de: la historia de la programación:_

- 1967: Nygaard y Dahl desarrollan _Simula '67_, revolucionario para su época, y puede ser considerado el primer lenguaje OOP. En ese tiempo, los principales paradigmas de programación era programar cerca de la máquina, dar instrucciones directas y específicas a la arquitectura, usaban mucho GoTo.
- 1968: Dijkstra escribe _Goto Considered Harmful_, lo que muchos consideran el nacimiento del ovimiento a la programación estructurada
- 197?: Dijkstra, ?? y ?? escriben _Structured Programming_.

En los 70's, en Xenox Parc (donde desarrollaron cosas tipo el protocolo ethernet, fua) aparecen de las primeras computadoras con gui y periféricos, corrían Smalltalk

**Smalltalk (1969-):** \
Alan Kay en Xerox Parc quería construír el \textit{proyecto Dynabook} (una especie de tablet para que los chicos aprendan a programar). Él mismo acuña el término OOP, y más de 10 años de desarrollo después (junto con Ada Goldberg y Dan Ingalls) termina en Smalltalk-80, un lenguaje pensado para acercar la programación al público común.

Smalltalk es un ambiente (tipo IDE + lang), diseñado con aprendizaje en mente, código abierto, Meta circular (definido en sí mismo), y de ambiente vivo (los cambios se realizan en tiempo real)

### Introducción al Desarrollo de Software:

**¿Qué es un Software?:** Conjunto de instrucciones que dad una entrada genera una salida. A.K.A. programa, app, etc. Esta es la definición clásica de Software.

En esta cátedra, se define como un _modelo computable de un dominio de problema de la realidad_:

- **Realidad:** lo que podemos percibir, hablar y pensar sobre, etc.
- **Dominio de problema:** una parte de esa realidad.
- **Modelo:** representación de ese dominio.
- **Computable:** que puede ser procesado por una computadora (No Busy Beavers nonsense!)

En principio, el objetivo de un programador es escribir Software que modele el dominio del problema \textit{en su totalidad} y \textit{sólamente el dominio del problema}, para que el programa sea efectivo y simple. El código en sí es el modelo de la realidad, y la principal tarea del ingeniero en software es escribir el código.

**Los 3 ejes de un buen modelo:**

1. _Funcional_: qué tan bien representa el dominio, en qué medida se comporta de acuerdo a la realidad.
2. _Descriptivo_: qué tan bien describe el problema. Cualquiera escribe código que una máquina puede leer, pero pocos escriben código que un humano pueda leer.
3. _Implementativo_: Cuán performante es, qué tan eficentemente utiliza los recursos de la máquina

**Características esenciales del software:** _(ver "No Silver Bullets")_

- Complejidad: el software es grande y no hay 2 programas iguales.
- Conformidad: el software modela cosas arbitrarias, definidas por humanos.
- Variabilidad: el software se tiene que adaptar a los cambios.
- Invisibilidad: el software es intangible.

Existe una complejidad esencial al problema, que viene del mero hecho de tener que modelar la realidad; y una complejidad accidental, específica de la implementación del software, el hardware utilizado, y otras situaciones no directamente relacionadas con el problema inicial.

**¿Qué es el Desarrollo de Software?** \
IEEE lo define como:

> “La aplicación de un enfoque sistemático, disciplinado y cuantificable al desarrollo, mantenimiento y operación de sistemas de software”. En general abarca todo el proceso de creación del software como ya lo definimos, pero también incluye el manejo, mantenimiento, validación, y documentación de dciho software.

En 1970 Royce describe el "Método cascada" del desarrollo de software, que se basa en trabajar paso a paso en los aspectos del software en orden: requerimientos del sistema, requerimientos del programa, analisis, diseño del programa, programación, pruebas, y operaciones. En sus propias palabras, este método es "riesgoso y propenso a fallos".

Después sobre los 2000' es que se empezaron a reevaluar estos métodos de producción (que en la práctica habían sido ineficientes y no se estaban usando). El \textit{Manifiesto Ágil}, un paper del 01' sobre el desarrollo de software, dice : \textit{<< Hemos aprendido a valorar individuos e interacciones sobre procesos y herramientas, software que funcione sobre documentación excesiva, colaboración con el cliente sobre negociación contractual, respuesta ante el cambio sobre seguir un plan. >>}

En efecto, en la práctica el desarrollo de software es un proceso mucho más iterativo, donde uno analiza parte del problema, lo implementa en código, lo prueba, y lo mejora, hasta llegar al producto final. Un par de años antes Kent Beck, uno de los principales responsables del \textit{Manifiesto Ágil}, escribía sobre el concepto del feedback en el desarrollo de software en su libro llamado \textit{Programación extrema}.

falta foto lmao
