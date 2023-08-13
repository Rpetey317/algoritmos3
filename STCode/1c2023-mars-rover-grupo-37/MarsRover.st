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

!MarsRoverTest methodsFor: 'testing' stamp: 'RABG 5/27/2023 01:04:25'!
test10RoverRecibeComandoInvalidoYSeDetiene

	[rover realizar: 'ffhf'. self fail]
		on: Error
		do: [:anError | self assert: (anError messageText) equals: (MarsRover descripcionComandoInvalido: $h)]
	! !


!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'rabg 5/24/2023 18:51:19'!
setUp

	rover := MarsRover newEn: (0@0) mirandoA: $N

	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'posicion direccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'acceso' stamp: 'RABG 5/29/2023 17:21:17'!
orientacion
	
	^(self class equivalenciasDeOrientacion) at: direccion 
		ifAbsent: [
			^self error: (self class descripcionOrientacionInvalida: direccion)
			] 
! !

!MarsRover methodsFor: 'acceso' stamp: 'rabg 5/24/2023 18:53:50'!
posicion

	^posicion ! !


!MarsRover methodsFor: 'inicializacion' stamp: 'RABG 5/29/2023 17:21:17'!
initializeEn: unaPosicion mirandoHacia: unaOrientacion

	posicion := unaPosicion. 
	direccion := unaOrientacion ! !


!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/29/2023 17:21:17'!
avanzar

	posicion := posicion + direccion ! !

!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/29/2023 09:50:50'!
ejecutarComando: unComando
	"Este método existe sólo por claridad al leer el código"

	^unComando value: self! !

!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/29/2023 09:50:37'!
interpretarComando: unComando

	|equivalencias comandoAEjecutar |
	
	equivalencias := self class equivalenciasDeComandos.
	comandoAEjecutar := equivalencias at: unComando 
		ifAbsent: [ 
			^self error: (self class descripcionComandoInvalido: unComando)
			].
	^self ejecutarComando: comandoAEjecutar ! !

!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/29/2023 17:21:17'!
retroceder

	posicion := posicion - direccion ! !

!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/29/2023 17:52:37'!
rotarDerecha

	direccion := (direccion rotatedBy: (-90 degreesToRadians)) asIntegerPoint 
! !

!MarsRover methodsFor: 'private - acciones' stamp: 'RABG 5/29/2023 17:52:40'!
rotarIzquierda

	direccion := (direccion rotatedBy: (90 degreesToRadians)) asIntegerPoint 
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

!MarsRover class methodsFor: 'instance creation' stamp: 'RABG 5/27/2023 01:03:04'!
newEn: unaPosicion mirandoA: unaOrientacion

	|versorCardinal|
	
	versorCardinal := self equivalenciasDeOrientacion keyAtValue: unaOrientacion 
	 	ifAbsent: [self error: (self descripcionOrientacionInvalida: unaOrientacion)].

	^self new initializeEn: unaPosicion mirandoHacia: versorCardinal.
! !


!MarsRover class methodsFor: 'error handling' stamp: 'RABG 5/26/2023 20:36:14'!
descripcionComandoInvalido: unComandoInvalido

	^'{1} no es un comando válido para el Mars Rover' format: {unComandoInvalido}! !

!MarsRover class methodsFor: 'error handling' stamp: 'RABG 5/27/2023 01:03:48'!
descripcionOrientacionInvalida: unaOrientacion

	^'{1} no es una orientación válida para el Mars Rover' format: {unaOrientacion}! !


!MarsRover class methodsFor: 'private - equivalencias' stamp: 'RABG 5/27/2023 01:00:27'!
equivalenciasDeComandos
	
	^Dictionary newFromPairs: {
		$f. [:rover | rover avanzar].
		$b. [:rover | rover retroceder].
		$l. [:rover | rover rotarIzquierda].
		$r. [:rover | rover rotarDerecha].
	}.! !

!MarsRover class methodsFor: 'private - equivalencias' stamp: 'RABG 5/27/2023 00:59:54'!
equivalenciasDeOrientacion

	^Dictionary newFromPairs: {
		(0@1).    $N.
		(0@-1). $S.
		(1@0).    $E.
		(-1@0). $O.
	}.! !
