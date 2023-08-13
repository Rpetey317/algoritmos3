!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'assertions' stamp: 'RABG 5/26/2023 21:19:54'!
assertRoverRealiza: unaSecuenciaDeAcciones yTerminaEn: unaPosicion mirandoHacia: unPuntoCardinal

	rover realizar: unaSecuenciaDeAcciones.
	self assert: unaPosicion equals: rover posicion.
	self assert: unPuntoCardinal equals: rover orientacion.! !


!MarsRoverTest methodsFor: 'testing' stamp: 'rabg 5/24/2023 18:49:05'!
test01MarsRoverRecibeComandoVacioYNoSeMueve

	rover realizar: ''.
	self assert: (0@0) equals: rover posicion.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rabg 5/24/2023 18:49:52'!
test02MarsRoverRecibeComandoVacioYNoRota

	rover realizar: ''.
	self assert: $N equals: rover orientacion.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'RABG 5/26/2023 21:22:38'!
test03MarsRoverEntiendeComandoAvanzar

	self assertRoverRealiza: 'f' yTerminaEn: (0@1) mirandoHacia: $N.
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'RABG 5/26/2023 21:23:27'!
test04MarsRoverEntiendeComandoRetroceder

	self assertRoverRealiza: 'b' yTerminaEn: (0@-1) mirandoHacia: $N.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'RABG 5/26/2023 21:57:19'!
test05MarsRoverEntiendeComandoRotarIzquierda

	self assertRoverRealiza: 'l' yTerminaEn: (0@0) mirandoHacia: $O! !

!MarsRoverTest methodsFor: 'testing' stamp: 'RABG 5/26/2023 21:24:18'!
test06MarsRoverEntiendeComandoRotarDerecha

	self assertRoverRealiza: 'r' yTerminaEn: (0@0) mirandoHacia: $E! !

!MarsRoverTest methodsFor: 'testing' stamp: 'RABG 5/26/2023 21:24:54'!
test07MarsRoverAvanzaMasDeUnaVez

	self assertRoverRealiza: 'fff' yTerminaEn: (0@3) mirandoHacia: $N! !

!MarsRoverTest methodsFor: 'testing' stamp: 'RABG 5/26/2023 21:25:15'!
test08MarsRoverRotaMasDeUnaVez

	self assertRoverRealiza: 'lll' yTerminaEn: (0@0) mirandoHacia: $E! !

!MarsRoverTest methodsFor: 'testing' stamp: 'RABG 5/26/2023 21:25:54'!
test09RoverRotaYSeMueveEnLaNuevaDireccion

	self assertRoverRealiza: 'lf' yTerminaEn: (-1@0) mirandoHacia: $O

	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'RABG 5/26/2023 21:52:36'!
test10RoverRecibeComandoInvalidoYSeDetiene

	[rover realizar: 'ffhf'. self fail]
		on: Error
		do: [:anError | self assert: (anError messageText) equals: (MarsRoverComando descripcionComandoInvalido: $h)]
	! !


!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'rabg 5/24/2023 18:51:19'!
setUp

	rover := MarsRover newEn: (0@0) mirandoA: $N

	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'posicion orientacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'acceso' stamp: 'RABG 5/26/2023 21:56:16'!
orientacion

	^orientacion valor.! !

!MarsRover methodsFor: 'acceso' stamp: 'rabg 5/24/2023 18:53:50'!
posicion

	^posicion ! !


!MarsRover methodsFor: 'inicializacion' stamp: 'RABG 5/26/2023 21:56:37'!
initializeEn: unaPosicion mirandoHacia: unaOrientacion

	posicion := unaPosicion. 
	orientacion := MarsRoverOrientacion mirandoHacia: unaOrientacion ! !


!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/26/2023 21:09:35'!
avanzar

	posicion := posicion + orientacion enFrente ! !

!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/26/2023 21:42:38'!
ejecutarInstruccion: unaInstruccion
	"Este método existe sólo por claridad al leer el código"

	^unaInstruccion value: self! !

!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/26/2023 21:43:00'!
interpretarComando: unComando

	|instruccionAEjecutar|
	
	instruccionAEjecutar := MarsRoverComando interpretarComando: unComando.
	^self ejecutarInstruccion: instruccionAEjecutar ! !

!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/26/2023 21:09:27'!
retroceder

	posicion := posicion + orientacion detras! !

!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/26/2023 21:09:45'!
rotarDerecha

	orientacion := orientacion derecha 
! !

!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/26/2023 21:09:50'!
rotarIzquierda

	orientacion := orientacion izquierda
! !


!MarsRover methodsFor: 'movimiento' stamp: 'RABG 5/26/2023 21:55:29'!
realizar: unaSecuenciaDeComandos

	unaSecuenciaDeComandos do: [:unComando|
		self interpretarComando: unComando 
		].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'rabg 5/24/2023 18:42:50'!
newEn: unaPosicion

	^self new.
! !

!MarsRover class methodsFor: 'instance creation' stamp: 'RABG 5/26/2023 21:56:10'!
newEn: unaPosicion mirandoA: unaOrientacion

	^self new initializeEn: unaPosicion mirandoHacia: unaOrientacion.
! !


!MarsRover class methodsFor: 'error handling' stamp: 'RABG 5/26/2023 20:36:14'!
descripcionComandoInvalido: unComandoInvalido

	^'{1} no es un comando válido para el Mars Rover' format: {unComandoInvalido}! !


!classDefinition: #MarsRoverComando category: 'MarsRover'!
Object subclass: #MarsRoverComando
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverComando class' category: 'MarsRover'!
MarsRoverComando class
	instanceVariableNames: ''!

!MarsRoverComando class methodsFor: 'interpretacion de comandos' stamp: 'RABG 5/26/2023 21:33:32'!
esComandoValido: unComando

	self subclassResponsibility ! !

!MarsRoverComando class methodsFor: 'interpretacion de comandos' stamp: 'RABG 5/26/2023 21:32:15'!
instruccion

	self subclassResponsibility! !

!MarsRoverComando class methodsFor: 'interpretacion de comandos' stamp: 'RABG 5/26/2023 21:35:48'!
interpretarComando: unComando

	self subclassesDo: [:unaSubclase|
		(unaSubclase esComandoValido: unComando) ifTrue: [
			^unaSubclase instruccion.
			]
		].
	^self error: (self descripcionComandoInvalido: unComando)! !


!MarsRoverComando class methodsFor: 'error handling' stamp: 'RABG 5/26/2023 21:35:32'!
descripcionComandoInvalido: unComandoInvalido

	^'{1} no es un comando válido para el Mars Rover' format: {unComandoInvalido}! !


!classDefinition: #MarsRoverComandoAvanzar category: 'MarsRover'!
MarsRoverComando subclass: #MarsRoverComandoAvanzar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverComandoAvanzar class' category: 'MarsRover'!
MarsRoverComandoAvanzar class
	instanceVariableNames: ''!

!MarsRoverComandoAvanzar class methodsFor: 'interpretacion de comandos' stamp: 'RABG 5/26/2023 21:33:08'!
esComandoValido: unComando

	^unComando = $f! !

!MarsRoverComandoAvanzar class methodsFor: 'interpretacion de comandos' stamp: 'RABG 5/26/2023 21:32:15'!
instruccion

	^[:rover | rover avanzar]! !


!classDefinition: #MarsRoverComandoRetroceder category: 'MarsRover'!
MarsRoverComando subclass: #MarsRoverComandoRetroceder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverComandoRetroceder class' category: 'MarsRover'!
MarsRoverComandoRetroceder class
	instanceVariableNames: ''!

!MarsRoverComandoRetroceder class methodsFor: 'interpretacion de comandos' stamp: 'RABG 5/26/2023 21:33:42'!
esComandoValido: unComando

	^unComando = $b! !

!MarsRoverComandoRetroceder class methodsFor: 'interpretacion de comandos' stamp: 'RABG 5/26/2023 21:33:47'!
instruccion

	^[:rover | rover retroceder]! !


!classDefinition: #MarsRoverComandoRotarDerecha category: 'MarsRover'!
MarsRoverComando subclass: #MarsRoverComandoRotarDerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverComandoRotarDerecha class' category: 'MarsRover'!
MarsRoverComandoRotarDerecha class
	instanceVariableNames: ''!

!MarsRoverComandoRotarDerecha class methodsFor: 'interpretacion de comandos' stamp: 'RABG 5/26/2023 21:33:58'!
esComandoValido: unComando

	^unComando = $r! !

!MarsRoverComandoRotarDerecha class methodsFor: 'interpretacion de comandos' stamp: 'RABG 5/26/2023 21:34:05'!
instruccion

	^[:rover | rover rotarDerecha]! !


!classDefinition: #MarsRoverComandoRotarIzquierda category: 'MarsRover'!
MarsRoverComando subclass: #MarsRoverComandoRotarIzquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverComandoRotarIzquierda class' category: 'MarsRover'!
MarsRoverComandoRotarIzquierda class
	instanceVariableNames: ''!

!MarsRoverComandoRotarIzquierda class methodsFor: 'interpretacion de comandos' stamp: 'RABG 5/26/2023 21:34:10'!
esComandoValido: unComando

	^unComando = $l! !

!MarsRoverComandoRotarIzquierda class methodsFor: 'interpretacion de comandos' stamp: 'RABG 5/26/2023 21:34:18'!
instruccion

	^[:rover | rover rotarIzquierda]! !


!classDefinition: #MarsRoverOrientacion category: 'MarsRover'!
Object subclass: #MarsRoverOrientacion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverOrientacion methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 20:56:55'!
derecha

	self subclassResponsibility! !

!MarsRoverOrientacion methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:00:03'!
detras

	^(self enFrente)*(-1@-1)! !

!MarsRoverOrientacion methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 20:57:10'!
enFrente

	self subclassResponsibility! !

!MarsRoverOrientacion methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 20:57:15'!
izquierda

	self subclassResponsibility! !

!MarsRoverOrientacion methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:05:00'!
valor

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientacion class' category: 'MarsRover'!
MarsRoverOrientacion class
	instanceVariableNames: ''!

!MarsRoverOrientacion class methodsFor: 'error handling' stamp: 'RABG 5/26/2023 20:55:29'!
descripcionOrientacionInvalida: unaOrientacion

	'{1} no es una orientación válida para el Mars Rover' format: {unaOrientacion}! !


!MarsRoverOrientacion class methodsFor: 'instance creation' stamp: 'RABG 5/26/2023 21:37:33'!
esOrientacionValida: unaOrientacion

	self subclassResponsibility ! !

!MarsRoverOrientacion class methodsFor: 'instance creation' stamp: 'RABG 5/26/2023 21:56:37'!
mirandoHacia: unaOrientacion

	self subclassesDo: [:unaSubclase|
		(unaSubclase esOrientacionValida: unaOrientacion) ifTrue: [
			^unaSubclase new.
			] 
		].
	^self error: (self descripcionOrientacionInvalida: unaOrientacion).! !


!classDefinition: #MarsRoverOrientacionEste category: 'MarsRover'!
MarsRoverOrientacion subclass: #MarsRoverOrientacionEste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverOrientacionEste methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:56:37'!
derecha

	^MarsRoverOrientacion mirandoHacia: $S! !

!MarsRoverOrientacionEste methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:00:50'!
enFrente

	^(1@0)! !

!MarsRoverOrientacionEste methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:56:37'!
izquierda

	^MarsRoverOrientacion mirandoHacia: $N! !

!MarsRoverOrientacionEste methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:05:07'!
valor

	^$E! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientacionEste class' category: 'MarsRover'!
MarsRoverOrientacionEste class
	instanceVariableNames: ''!

!MarsRoverOrientacionEste class methodsFor: 'instance creation' stamp: 'RABG 5/26/2023 21:37:33'!
esOrientacionValida: unaOrientacion

	^unaOrientacion = $E! !


!classDefinition: #MarsRoverOrientacionNorte category: 'MarsRover'!
MarsRoverOrientacion subclass: #MarsRoverOrientacionNorte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverOrientacionNorte methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:56:37'!
derecha

	^MarsRoverOrientacion mirandoHacia: $E! !

!MarsRoverOrientacionNorte methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:01:49'!
enFrente

	^(0@1)! !

!MarsRoverOrientacionNorte methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:56:37'!
izquierda

	^MarsRoverOrientacion mirandoHacia: $O! !

!MarsRoverOrientacionNorte methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:05:00'!
valor

	^$N! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientacionNorte class' category: 'MarsRover'!
MarsRoverOrientacionNorte class
	instanceVariableNames: ''!

!MarsRoverOrientacionNorte class methodsFor: 'instance creation' stamp: 'RABG 5/26/2023 21:37:33'!
esOrientacionValida: unaOrientacion

	^unaOrientacion = $N! !


!classDefinition: #MarsRoverOrientacionOeste category: 'MarsRover'!
MarsRoverOrientacion subclass: #MarsRoverOrientacionOeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverOrientacionOeste methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:56:37'!
derecha

	^MarsRoverOrientacion mirandoHacia: $N! !

!MarsRoverOrientacionOeste methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:02:48'!
enFrente

	^(-1@0)! !

!MarsRoverOrientacionOeste methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:56:37'!
izquierda

	^MarsRoverOrientacion mirandoHacia: $S! !

!MarsRoverOrientacionOeste methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:05:13'!
valor

	^$O! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientacionOeste class' category: 'MarsRover'!
MarsRoverOrientacionOeste class
	instanceVariableNames: ''!

!MarsRoverOrientacionOeste class methodsFor: 'instance creation' stamp: 'RABG 5/26/2023 21:37:33'!
esOrientacionValida: unaOrientacion

	^unaOrientacion = $O! !


!classDefinition: #MarsRoverOrientacionSur category: 'MarsRover'!
MarsRoverOrientacion subclass: #MarsRoverOrientacionSur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverOrientacionSur methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:56:37'!
derecha

	^MarsRoverOrientacion mirandoHacia: $O! !

!MarsRoverOrientacionSur methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:03:33'!
enFrente

	^(0@-1)! !

!MarsRoverOrientacionSur methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:56:37'!
izquierda

	^MarsRoverOrientacion mirandoHacia: $E! !

!MarsRoverOrientacionSur methodsFor: 'private - accessing' stamp: 'RABG 5/26/2023 21:05:18'!
valor

	^$S! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientacionSur class' category: 'MarsRover'!
MarsRoverOrientacionSur class
	instanceVariableNames: ''!

!MarsRoverOrientacionSur class methodsFor: 'instance creation' stamp: 'RABG 5/26/2023 21:37:33'!
esOrientacionValida: unaOrientacion

	^unaOrientacion = $S! !
