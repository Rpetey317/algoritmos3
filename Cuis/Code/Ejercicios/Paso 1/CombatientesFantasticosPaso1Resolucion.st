!classDefinition: #Arthas category: 'CombatientesFantasticosPaso1'!
DenotativeObject subclass: #Arthas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CombatientesFantasticosPaso1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arthas class' category: 'CombatientesFantasticosPaso1'!
Arthas class
	instanceVariableNames: 'armaduraActual dañoARealizar vidaActual enemigos foco'!

!Arthas class methodsFor: 'Stats' stamp: 'RABG 3/31/2023 19:49:23'!
enemigos: listaDeEnemigos
	enemigos := listaDeEnemigos ! !

!Arthas class methodsFor: 'Stats' stamp: 'RABG 3/31/2023 19:20:25'!
puntosDeVida
	^vidaActual .! !


!Arthas class methodsFor: 'Equipar' stamp: 'RABG 3/31/2023 19:14:09'!
equiparEspada
	dañoARealizar := 8.! !

!Arthas class methodsFor: 'Equipar' stamp: 'RABG 3/31/2023 19:14:09'!
equiparHacha
	dañoARealizar := 10.! !


!Arthas class methodsFor: 'Cambiar Foco' stamp: 'RABG 4/4/2023 19:18:44'!
focalizarEnElMasHerido
	foco := [: unosEnemigos | unosEnemigos detectMin: [: unEnemigo | unEnemigo puntosDeVida ]].! !

!Arthas class methodsFor: 'Cambiar Foco' stamp: 'RABG 4/4/2023 19:19:15'!
focalizarEnElMasSano
	foco := [: unosEnemigos | unosEnemigos detectMax: [: unEnemigo | unEnemigo puntosDeVida ]]! !

!Arthas class methodsFor: 'Cambiar Foco' stamp: 'RABG 4/4/2023 19:20:26'!
focalizarEnUnoAleatorio
	foco := [:unosEnemigos | unosEnemigos anyOne ]! !


!Arthas class methodsFor: 'Acciones' stamp: 'RABG 4/4/2023 19:34:33'!
atacar
	|enemigoAAtacar|
	enemigos ifEmpty: [^self].
	
	enemigoAAtacar  := foco valueWithArguments: {enemigos} .
	self atacarA: enemigoAAtacar ! !

!Arthas class methodsFor: 'Acciones' stamp: 'RABG 3/31/2023 19:14:09'!
atacarA: unaVictima
	unaVictima recibeDaño: dañoARealizar .! !

!Arthas class methodsFor: 'Acciones' stamp: 'RABG 3/31/2023 20:22:20'!
elegirEnemigoSegunEstrategia

	|estrategia|

	foco = #ElMasHerido
		ifTrue: [estrategia := [: unosEnemigos | unosEnemigos detectMin: [: unEnemigo | unEnemigo puntosDeVida ]]].

	foco = #ElMasSano
		ifTrue: [estrategia := [: unosEnemigos | unosEnemigos detectMax: [: unEnemigo | unEnemigo puntosDeVida ]]].
		
	foco = #CualquierEnemigo
		ifTrue: [estrategia := [enemigos anyOne ]].
			
	^estrategia value.! !

!Arthas class methodsFor: 'Acciones' stamp: 'RABG 4/4/2023 19:31:42'!
reestablecer
	vidaActual := 20.
	dañoARealizar  := 2.
	armaduraActual := 0.
	enemigos  := #().	
	foco := [:unosEnemigos | unosEnemigos anyOne ].! !


!Arthas class methodsFor: '--** private fileout/in **--' stamp: 'RABG 4/4/2023 19:39:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	armaduraActual := 0.
	dañoARealizar := 2.
	vidaActual := 20.
	enemigos := ((Array new: 2) at: 1 put: Olgra; at: 2 put: Mankrik; yourself).
	foco := ((SerializableBlockClosure basicNew instVarAt: 1 put: Arthas; instVarAt: 2 put: '[ :argm4_1 |
	argm4_1 anyOne. ]'; instVarAt: 3 put: #(); yourself) asEvaluable).! !


!classDefinition: #CombatientesTest category: 'CombatientesFantasticosPaso1'!
DenotativeObject subclass: #CombatientesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CombatientesFantasticosPaso1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CombatientesTest class' category: 'CombatientesFantasticosPaso1'!
CombatientesTest class
	instanceVariableNames: ''!

!CombatientesTest class methodsFor: 'para completar' stamp: 'RABG 3/31/2023 17:53:44'!
combatienteHumanoArthas
	^Arthas ! !

!CombatientesTest class methodsFor: 'para completar' stamp: 'RABG 3/31/2023 19:48:16'!
combatienteOrcoMankrik
	^Mankrik ! !

!CombatientesTest class methodsFor: 'para completar' stamp: 'RABG 3/31/2023 17:53:55'!
combatienteOrcoOlgra
	^Olgra! !

!CombatientesTest class methodsFor: 'para completar' stamp: 'RABG 3/31/2023 19:48:02'!
comenzarUnNuevoCombate
	self combatienteOrcoOlgra reestablecer.
	self combatienteHumanoArthas reestablecer.
	self combatienteOrcoMankrik reestablecer.	! !


!CombatientesTest class methodsFor: 'combatientes tests' stamp: 'SF 8/27/2022 05:58:49'!
test01UnCombatientePuedeAtacarAOtro
	
	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert that: self combatienteOrcoOlgra puntosDeVida isEqualTo: 18.! !

!CombatientesTest class methodsFor: 'combatientes tests' stamp: 'SF 8/27/2022 06:06:50'!
test02MultiplesAtaquesVanBajandoMasVida

	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert that: self combatienteOrcoOlgra puntosDeVida isEqualTo: 16.! !

!CombatientesTest class methodsFor: 'combatientes tests' stamp: 'SF 3/28/2023 15:08:27'!
test03UnHachaHace10DeDaño

	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas equiparHacha.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert that: self combatienteOrcoOlgra puntosDeVida isEqualTo: 10.! !

!CombatientesTest class methodsFor: 'combatientes tests' stamp: 'SF 3/28/2023 15:08:35'!
test04UnEspadaHace8DeDaño

	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas equiparEspada.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert that: self combatienteOrcoOlgra puntosDeVida isEqualTo: 12.! !

!CombatientesTest class methodsFor: 'combatientes tests' stamp: 'SF 3/28/2023 15:08:47'!
test05UnaArmaduraDeCueroAbsorbe2DeDaño

	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas equiparEspada.
	self combatienteOrcoOlgra equiparArmaduraDeCuero.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert that: self combatienteOrcoOlgra puntosDeVida isEqualTo: 14.! !

!CombatientesTest class methodsFor: 'combatientes tests' stamp: 'SF 3/28/2023 15:09:04'!
test06UnaArmaduraDeMetalAbsorbe6DeDaño

	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas equiparEspada.
	self combatienteOrcoOlgra equiparArmaduraDeMetal.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert that: self combatienteOrcoOlgra puntosDeVida isEqualTo: 18.! !

!CombatientesTest class methodsFor: 'combatientes tests' stamp: 'SF 3/28/2023 15:09:12'!
test07UnaArmaduraReduceElDañoInfligidoACero

	self comenzarUnNuevoCombate.
	self combatienteOrcoOlgra equiparArmaduraDeMetal.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert that: self combatienteOrcoOlgra puntosDeVida isEqualTo: 20.! !


!CombatientesTest class methodsFor: 'atacar tests' stamp: 'JMB 8/27/2022 13:54:53'!
test08CuandoUnCombatienteNoTieneEnemigosNoAtacaANadie
	
	self comenzarUnNuevoCombate.
	
	self combatienteHumanoArthas atacar.
	
	Assert that: self combatienteOrcoOlgra puntosDeVida isEqualTo: 20.
	Assert that: self combatienteOrcoMankrik puntosDeVida isEqualTo: 20.
	
	! !

!CombatientesTest class methodsFor: 'atacar tests' stamp: 'SF 8/27/2022 06:07:34'!
test09CuandoUnCombatienteTieneEnemigosAtacaAUno
	| enemigo1Herido enemigo2Herido |
	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas enemigos: {self combatienteOrcoOlgra . self combatienteOrcoMankrik .}.
	
	self combatienteHumanoArthas atacar.
	
	enemigo1Herido := self combatienteOrcoOlgra puntosDeVida < 20 and: [self combatienteOrcoMankrik puntosDeVida = 20].
	enemigo2Herido := self combatienteOrcoMankrik puntosDeVida < 20 and: [self combatienteOrcoOlgra puntosDeVida = 20].
	Assert isTrue: (enemigo1Herido or: [enemigo2Herido]).! !

!CombatientesTest class methodsFor: 'atacar tests' stamp: 'JMB 8/27/2022 13:55:22'!
test10UnCombatientePuedeTenerComoEstrategiaAtacarAlMasHerido
	
	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas enemigos: {self combatienteOrcoOlgra. self combatienteOrcoMankrik.}.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	self combatienteHumanoArthas focalizarEnElMasHerido.
	self combatienteHumanoArthas atacar.

	Assert that: self combatienteOrcoOlgra puntosDeVida isEqualTo: 16.
	! !

!CombatientesTest class methodsFor: 'atacar tests' stamp: 'SF 3/28/2023 15:10:08'!
test11UnCombatientePuedeTenerComoEstrategiaAtacarAlMasSano
	
	self comenzarUnNuevoCombate.
	
	self combatienteHumanoArthas equiparEspada .
	self combatienteHumanoArthas enemigos: {self combatienteOrcoOlgra. self combatienteOrcoMankrik.}.
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.
	
	self combatienteHumanoArthas focalizarEnElMasSano.
	self combatienteHumanoArthas atacar.
	
	Assert that: self combatienteOrcoOlgra puntosDeVida isEqualTo: 12.! !


!classDefinition: #Mankrik category: 'CombatientesFantasticosPaso1'!
DenotativeObject subclass: #Mankrik
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CombatientesFantasticosPaso1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mankrik class' category: 'CombatientesFantasticosPaso1'!
Mankrik class
	instanceVariableNames: 'dañoARealizar vidaActual armaduraActual'!

!Mankrik class methodsFor: 'Stats' stamp: 'RABG 3/31/2023 19:43:46'!
puntosDeVida
	^vidaActual .! !


!Mankrik class methodsFor: 'Acciones' stamp: 'RABG 3/31/2023 19:43:46'!
atacarA: unaVictima
	unaVictima recibeDaño: dañoARealizar .! !

!Mankrik class methodsFor: 'Acciones' stamp: 'RABG 3/31/2023 19:43:46'!
recibeDaño: puntosDeDaño
	|dañoTotal|
	
	(puntosDeDaño < armaduraActual) 
		ifTrue: [dañoTotal := 0]
		ifFalse: [dañoTotal  := puntosDeDaño - armaduraActual].
		
	vidaActual := vidaActual - (dañoTotal ) .! !

!Mankrik class methodsFor: 'Acciones' stamp: 'RABG 3/31/2023 19:43:46'!
reestablecer
	vidaActual := 20.
	armaduraActual := 0.! !


!Mankrik class methodsFor: 'Equipar' stamp: 'RABG 3/31/2023 19:43:46'!
equiparArmaduraDeCuero
	armaduraActual := 2.! !

!Mankrik class methodsFor: 'Equipar' stamp: 'RABG 3/31/2023 19:43:46'!
equiparArmaduraDeMetal
	armaduraActual := 6.! !


!Mankrik class methodsFor: '--** private fileout/in **--' stamp: 'RABG 4/4/2023 19:39:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	dañoARealizar := 20.
	vidaActual := 20.
	armaduraActual := 0.! !


!classDefinition: #Olgra category: 'CombatientesFantasticosPaso1'!
DenotativeObject subclass: #Olgra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CombatientesFantasticosPaso1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Olgra class' category: 'CombatientesFantasticosPaso1'!
Olgra class
	instanceVariableNames: 'dañoARealizar vidaActual armaduraActual'!

!Olgra class methodsFor: 'Stats' stamp: 'RABG 3/31/2023 19:09:32'!
puntosDeVida
	^vidaActual .! !


!Olgra class methodsFor: 'Acciones' stamp: 'RABG 3/31/2023 19:04:40'!
atacarA: unaVictima
	unaVictima recibeDaño: dañoARealizar .! !

!Olgra class methodsFor: 'Acciones' stamp: 'RABG 3/31/2023 19:41:44'!
recibeDaño: puntosDeDaño
	|dañoTotal|
	
	(puntosDeDaño < armaduraActual) 
		ifTrue: [dañoTotal := 0]
		ifFalse: [dañoTotal  := puntosDeDaño - armaduraActual].
		
	vidaActual := vidaActual - (dañoTotal ) .! !

!Olgra class methodsFor: 'Acciones' stamp: 'RABG 3/31/2023 19:25:51'!
reestablecer
	vidaActual := 20.
	armaduraActual := 0.! !


!Olgra class methodsFor: 'Equipar' stamp: 'RABG 3/31/2023 19:29:28'!
equiparArmaduraDeCuero
	armaduraActual := 2.! !

!Olgra class methodsFor: 'Equipar' stamp: 'RABG 3/31/2023 19:33:44'!
equiparArmaduraDeMetal
	armaduraActual := 6.! !


!Olgra class methodsFor: '--** private fileout/in **--' stamp: 'RABG 4/4/2023 19:39:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	dañoARealizar := 20.
	vidaActual := 18.
	armaduraActual := 0.! !

Arthas initializeAfterFileIn!
Mankrik initializeAfterFileIn!
Olgra initializeAfterFileIn!