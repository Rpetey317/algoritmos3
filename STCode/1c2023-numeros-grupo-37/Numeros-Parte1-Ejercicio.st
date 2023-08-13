!classDefinition: #NumeroTest category: 'Numeros-Parte1-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:40'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:53'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:00:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:00:32'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:01:10'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Numero with: (Numero with: 7) over: (Numero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:01:43'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:11'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Numero with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:28'!
test10AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:42'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (twoFifth) * (fiveHalfs) ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:04:04'!
test14NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:05:06'!
test15NegationOfFraccionIsCorrect

	self assert: (Numero with: negativeOne over: two) equals: oneHalf negated! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:29:45'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Numero with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:30:07'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Numero with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/8/2019 21:09:34'!
setUp

	zero := Numero with: 0.
	one := Numero with: 1.
	two := Numero with: 2.
	three:= Numero with: 3.
	four := Numero with: 4.
	five := Numero with: 5.
	eight := Numero with: 8.
	negativeOne := Numero with: -1.
	negativeTwo := Numero with: -2.
	
	oneHalf := Numero with: one over: two.
	oneFifth := Numero with: one over: five.
	twoFifth := Numero with: two over: five.
	twoTwentyfifth := Numero with: two over: (Numero with: 25).
	fiveHalfs := Numero with: five over: two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte1-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'rabg 4/25/2023 22:07:51'!
* aMultiplier 

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'rabg 4/25/2023 22:07:42'!
+ anAdder 
	
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'rabg 4/25/2023 22:07:31'!
negated
	
	self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'rabg 4/25/2023 21:42:01'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'rabg 4/25/2023 21:41:56'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'rabg 4/25/2023 21:41:48'!
isZero

	self subclassResponsibility ! !



!Numero methodsFor: 'accessing' stamp: 'rabg 4/28/2023 18:14:54'!
type
	self subclassResponsibility ! !


!Numero methodsFor: 'printing' stamp: 'rabg 4/28/2023 17:53:36'!
printOn: aStream
	
	self subclassResponsibility ! !


!Numero methodsFor: 'comparing' stamp: 'rabg 4/28/2023 17:51:30'!
= anObject

	self subclassResponsibility ! !

!Numero methodsFor: 'comparing' stamp: 'rabg 4/28/2023 17:52:23'!
hash
	self subclassResponsibility ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte1-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !


!Numero class methodsFor: 'instance creation' stamp: 'rabg 4/25/2023 21:33:59'!
with: aValue 
	
	^Entero with: aValue ! !

!Numero class methodsFor: 'instance creation' stamp: 'rabg 4/25/2023 21:33:10'!
with: aDividend over: aDivisor

	^Fraccion with: aDividend over: aDivisor ! !


!classDefinition: #Entero category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Entero methodsFor: 'initialization' stamp: 'rabg 4/25/2023 21:43:16'!
initializeWith: aValue
	
	value := aValue.
	type := #Entero.! !


!Entero methodsFor: 'testing' stamp: 'rabg 4/25/2023 21:39:29'!
isNegative
	^value < 0.! !

!Entero methodsFor: 'testing' stamp: 'rabg 4/25/2023 21:39:17'!
isOne
	^value = 1.! !

!Entero methodsFor: 'testing' stamp: 'rabg 4/25/2023 21:39:22'!
isZero
	^value = 0.! !


!Entero methodsFor: 'accessing' stamp: 'rabg 4/25/2023 21:52:19'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

!Entero methodsFor: 'accessing' stamp: 'rabg 4/28/2023 18:14:35'!
type
	^#Entero! !


!Entero methodsFor: 'printing' stamp: 'rabg 4/25/2023 21:55:10'!
printOn: aStream
	
	aStream print: value .! !


!Entero methodsFor: 'comparing' stamp: 'rabg 4/25/2023 21:57:28'!
= anObject

	^(anObject isKindOf: self class) 
		ifTrue: [ ^value = anObject integerValue] 
		ifFalse: [ ^false ].
		! !

!Entero methodsFor: 'comparing' stamp: 'rabg 4/25/2023 22:00:29'!
hash
	^value hash! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'rabg 4/25/2023 22:01:18'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue.
		! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'rabg 4/25/2023 22:03:12'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)
		
	! !


!Entero methodsFor: 'arithmetic operations' stamp: 'rabg 4/25/2023 22:04:46'!
* aMultiplier 

	(aMultiplier type = #Entero) ifTrue:	
		[ ^self class with: value * aMultiplier integerValue ].
		
	self error: 'Tipo de número no soportado'
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rabg 4/25/2023 21:26:02'!
+ anAdder 
	
	anAdder type = #Entero ifTrue:
		[ ^self class with: value + anAdder integerValue ].
	
	self error: 'Tipo de número no soportado'
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rabg 4/25/2023 22:06:49'!
negated
	
	^self * (self class with: -1).
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Parte1-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'rabg 4/25/2023 21:33:31'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Fraccion methodsFor: 'initialization' stamp: 'rabg 4/25/2023 21:43:33'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator.
	type := #Fraccion ! !


!Fraccion methodsFor: 'testing' stamp: 'rabg 4/25/2023 21:48:42'!
isNegative
	^denominator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'rabg 4/25/2023 21:48:34'!
isOne
	^false.! !

!Fraccion methodsFor: 'testing' stamp: 'rabg 4/25/2023 21:48:27'!
isZero
	^false.! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'rabg 4/25/2023 21:24:56'!
* aMultiplier 

	aMultiplier type = #Fraccion ifTrue:
		[ ^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator) ].
		
	self error: 'Tipo de número no soportado'! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rabg 4/25/2023 21:26:52'!
+ anAdder 
	
	anAdder type = #Fraccion ifTrue:
		[ | newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator ].
	
	self error: 'Tipo de número no soportado'
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rabg 4/25/2023 22:06:24'!
negated

	 ^self class with: numerator * (super class with: -1) over: denominator.! !


!Fraccion methodsFor: 'printing' stamp: 'rabg 4/25/2023 21:54:45'!
printOn: aStream
	
	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator.! !


!Fraccion methodsFor: 'comparing' stamp: 'rabg 4/25/2023 21:58:19'!
= anObject

	^(anObject isKindOf: self class) 
		ifTrue: [ ^(numerator * anObject denominator) = (denominator * anObject numerator)] 
		ifFalse: [ ^false ].
		! !

!Fraccion methodsFor: 'comparing' stamp: 'rabg 4/25/2023 21:59:11'!
hash
	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'rabg 4/25/2023 21:53:50'!
denominator

	^denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'rabg 4/25/2023 21:53:39'!
numerator

	^numerator! !

!Fraccion methodsFor: 'accessing' stamp: 'rabg 4/28/2023 18:13:15'!
type
	^#Fraccion! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Parte1-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'rabg 4/25/2023 21:36:23'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	(aDivisor isZero) ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	(aDividend isZero) ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !
