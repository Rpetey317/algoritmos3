# Métodos, Mensajes y Colaboradores

En la comunicación cotidiana entre personas existe la idea de un _emisor_, que emite un _mensaje_, hacia un _receptor_. \
Los objetos en Smalltalk se comportan de manera similar: son _receptores_ de _mensajes_, que _emite_ el programador u otro objeto. \
Este proceso se basa en ciertos paradigmas:

1. La comunicación es _sincrónica_
2. Los mensajes están _dirigidos_, específicamente hacia un objeto.
3. El receptor _desconoce al emisor_, el objeto no tiene en cuenta qué o quién lo llamó.
4. El objeto _siempre da una respuesta_, en concreto, un objeto. Si no se le especifica devolver nada se devuelve a sí mismo. Si se le especifica devolver nada, "nada" es un objeto

En Smalltalk, los objetos reciben _mensajes_, y cuando reciben un mensaje, buscan si tienen un _método_ para poder responderlo. \
Los **Métodos** son código que un objeto llama cuando recibe el mensaje correspondiente. Actúa como una función: ejecuta ciertas instrucciones y devuelve un objeto.


