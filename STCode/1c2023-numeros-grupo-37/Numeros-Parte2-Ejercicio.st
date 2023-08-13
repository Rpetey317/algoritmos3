!classDefinition: #NumeroTest category: 'Numeros-Parte2-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:50'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:58'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:39:57'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:10'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:22'!
test07EnteroDividesEnteroCorrectly

	self assert: one equals: two / two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:57'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:20'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:34'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: fiveHalfs equals: oneHalf / oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:58'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: (Entero with: 6) / (Entero with: 5) equals: one + oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:42:29'!
test12FraccionAddsEnteroCorrectly

	self assert: (Entero with: 6) / (Entero with: 5) equals: oneFifth + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:16'!
test13EnteroMultipliesFraccionCorrectly

	self assert: twoFifth equals: two * oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:27'!
test14FraccionMultipliesEnteroCorrectly

	self assert: twoFifth equals: oneFifth * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:40'!
test15EnteroDividesFraccionCorrectly

	self assert: fiveHalfs equals: one / twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:58'!
test16FraccionDividesEnteroCorrectly

	self assert: twoTwentyfifth equals: twoFifth / five! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:44:53'!
test19AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:13'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (two/five) * (five/two)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:27'!
test21DividingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf / oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:40'!
test22DividingEnterosCanReturnAFraccion

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:17'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:32'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:21'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two equals: three - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:36'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: oneFifth equals: twoFifth - oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:50'!
test29EnteroSubstractsFraccionCorrectly

	self assert: oneHalf equals: one - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:11'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: oneFifth equals: sixFifth - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:25'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: one equals: threeHalfs - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:44'!
test32SubstractingSameEnterosReturnsZero

	self assert: zero equals: one - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:59'!
test33SubstractingSameFraccionesReturnsZero

	self assert: zero equals: oneHalf - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:16'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: negativeThreeHalfs equals: one - fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:45'!
test35FibonacciZeroIsOne

	self assert: one equals: zero fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:58'!
test36FibonacciOneIsOne

	self assert: one equals: one fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:24'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: five equals: four fibonacci.
	self assert: three equals: three fibonacci. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:40'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: Entero negativeFibonacciErrorDescription equals: anError messageText ]! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:17'!
test39NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated
		! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:53:27'!
test40NegationOfFraccionIsCorrect

	self assert: negativeOne / two equals: oneHalf negated ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte2-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'RABG 4/30/2023 17:55:20'!
negated

	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'private' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte2-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:47:38'!
canNotDivideByZeroErrorDescription

	^'No se puede Dividir por Cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:46:56'!
invalidNumberTypeErrorDescription
	^ 'Tipo de Número Inválido'! !


!classDefinition: #Entero category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Entero methodsFor: 'arithmetic operations' stamp: 'rabg 4/28/2023 18:54:36'!
* aMultiplier 
	
	^aMultiplier multiplyWithEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rabg 4/28/2023 18:28:41'!
+ anAdder 
	
	^anAdder addToEntero: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rabg 4/28/2023 19:18:14'!
- aSubtrahend 
	
	^aSubtrahend substractAnEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rabg 4/28/2023 19:04:15'!
/ aDivisor 
	
	^aDivisor divideAnEntero: self ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'RABG 4/30/2023 15:17:39'!
fibonacci

	^ (self - (Entero with: 1)) fibonacci + (self - (Entero with: 2)) fibonacci
		! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'JS 5/5/2022 03:55:37'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'dd - arithmetic ops' stamp: 'RABG 4/30/2023 18:10:08'!
addToEntero: anAdder

	^Entero with: (self integerValue + anAdder integerValue)! !

!Entero methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:26:40'!
addToFraccion: anAdder
	|newNumerator|
	newNumerator := (self * anAdder denominator) + anAdder numerator.
	^newNumerator / anAdder denominator .! !

!Entero methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:26:07'!
divideAFraccion: aDividend
	^Fraccion with: aDividend numerator over: (self * aDividend denominator)! !

!Entero methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:26:51'!
divideAnEntero: aDividend
	^Fraccion with: aDividend over: self! !

!Entero methodsFor: 'dd - arithmetic ops' stamp: 'RABG 4/30/2023 18:10:53'!
multiplyWithEntero: aMultiplier

	^Entero with: (self integerValue * aMultiplier integerValue)! !

!Entero methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:27:59'!
multiplyWithFraccion: aMultiplier

	^(self * aMultiplier numerator) / (aMultiplier denominator)! !

!Entero methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:28:08'!
substractAFraccion: aMinuend
	|newNumerator|
	newNumerator := aMinuend numerator - (self * aMinuend denominator).
	^newNumerator / aMinuend denominator .! !

!Entero methodsFor: 'dd - arithmetic ops' stamp: 'RABG 4/30/2023 18:11:02'!
substractAnEntero: aMinuend
	^ Entero with: aMinuend integerValue - value.! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'RABG 4/30/2023 15:01:31'!
isNegative
	^false! !

!Entero methodsFor: 'testing' stamp: 'RABG 4/30/2023 15:03:00'!
isOne
	
	^false! !

!Entero methodsFor: 'testing' stamp: 'RABG 4/30/2023 15:03:05'!
isZero
	
	^false! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'RABG 4/30/2023 18:09:35'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'RABG 4/30/2023 18:10:30'!
greatestCommonDivisorWith: anEntero 
	
	^Entero with: (value gcd: anEntero integerValue)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Parte2-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'RABG 4/30/2023 18:11:40'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	
	Entero subclassesDo: [:aEnteroSubclass |
		(aEnteroSubclass isValidValue: aValue) ifTrue:[
			^aEnteroSubclass with: aValue]
		].

	^Entero new initializeWith: aValue! !


!classDefinition: #NegativeEntero category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #NegativeEntero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!NegativeEntero methodsFor: 'testing' stamp: 'RABG 4/30/2023 15:01:25'!
isNegative
	^true! !


!NegativeEntero methodsFor: 'arithmetic operations' stamp: 'RABG 4/30/2023 15:15:17'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription

		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NegativeEntero class' category: 'Numeros-Parte2-Ejercicio'!
NegativeEntero class
	instanceVariableNames: ''!

!NegativeEntero class methodsFor: 'instance creation' stamp: 'RABG 4/30/2023 18:06:06'!
isValidValue: aValue

	^aValue < 0! !

!NegativeEntero class methodsFor: 'instance creation' stamp: 'RABG 4/30/2023 18:36:53'!
with: aValue

	"Este chequeo está por seguridad, pero no es necesario para que corran los tests -Rubén"
	(self isValidValue: aValue) ifFalse:[^Entero with: aValue].
	
	^self new initializeWith: aValue! !


!classDefinition: #One category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #One
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!One methodsFor: 'initialization' stamp: 'RABG 4/30/2023 14:45:31'!
initialize
	value := 1! !


!One methodsFor: 'testing' stamp: 'RABG 4/30/2023 15:02:31'!
isOne
	
	^true! !


!One methodsFor: 'arithmetic operations' stamp: 'RABG 4/30/2023 15:16:15'!
fibonacci

	^Entero with: 1
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'One class' category: 'Numeros-Parte2-Ejercicio'!
One class
	instanceVariableNames: ''!

!One class methodsFor: 'instance creation' stamp: 'RABG 4/30/2023 18:05:59'!
isValidValue: aValue

	^aValue = 1! !

!One class methodsFor: 'instance creation' stamp: 'RABG 4/30/2023 18:37:03'!
with: aValue

	"Este chequeo está por seguridad, pero no es necesario para que corran los tests -Rubén"
	(self isValidValue: aValue) ifFalse:[^Entero with: aValue]. 

	^self new initialize ! !


!classDefinition: #Zero category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Zero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Zero methodsFor: 'initialization' stamp: 'RABG 4/30/2023 14:45:42'!
initialize
	value := 0! !


!Zero methodsFor: 'testing' stamp: 'RABG 4/30/2023 15:02:53'!
isZero
	
	^true! !


!Zero methodsFor: 'arithmetic operations' stamp: 'RABG 4/30/2023 15:16:22'!
fibonacci

	^Entero with: 1
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Zero class' category: 'Numeros-Parte2-Ejercicio'!
Zero class
	instanceVariableNames: ''!

!Zero class methodsFor: 'instance creation' stamp: 'RABG 4/30/2023 18:05:51'!
isValidValue: aValue

	^aValue = 0! !

!Zero class methodsFor: 'instance creation' stamp: 'RABG 4/30/2023 18:37:11'!
with: aValue

	"Este chequeo está por seguridad, pero no es necesario para que corran los tests -Rubén"
	(self isValidValue: aValue) ifFalse:[^Entero with: aValue]. 

	^self new initialize ! !


!classDefinition: #Fraccion category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rabg 4/28/2023 19:10:59'!
* aMultiplier 
	
	^aMultiplier multiplyWithFraccion: self	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rabg 4/28/2023 18:38:19'!
+ anAdder 
	
	^anAdder addToFraccion: self.
	
	"
	| newNumerator newDenominator |
	
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
	
	^newNumerator / newDenominator 
	"! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rabg 4/28/2023 19:24:12'!
- aSubtrahend 
	
	^aSubtrahend substractAFraccion: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rabg 4/28/2023 19:00:22'!
/ aDivisor 
	
	^aDivisor divideAFraccion: self! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:29:31'!
addToEntero: anAdder
	|newNumerator|
	newNumerator := (anAdder * denominator) + numerator.
	^newNumerator / denominator .! !

!Fraccion methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:29:51'!
addToFraccion: anAdder
	
	| newNumerator newDenominator |
	
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
	
	^newNumerator / newDenominator 
	! !

!Fraccion methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:30:05'!
divideAFraccion: aDividend
	^ (denominator * aDividend numerator) / (numerator * aDividend denominator).	
! !

!Fraccion methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:30:13'!
divideAnEntero: aDividend
	^(denominator * aDividend) / (numerator)
	
! !

!Fraccion methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:30:27'!
multiplyWithEntero: aMultiplier
	^(aMultiplier * numerator) / (denominator)! !

!Fraccion methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:30:35'!
multiplyWithFraccion: aMultiplier
	^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator)
! !

!Fraccion methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:30:44'!
substractAFraccion: aMinuend
	| newNumerator newDenominator |
	
	newNumerator :=  (denominator * aMinuend numerator) - (numerator * aMinuend denominator).
	newDenominator := denominator * aMinuend denominator.
	
	^newNumerator / newDenominator 
! !

!Fraccion methodsFor: 'dd - arithmetic ops' stamp: 'rabg 4/28/2023 20:30:57'!
substractAnEntero: aMinuend
	|newNumerator|
	newNumerator := (aMinuend * denominator) - numerator.
	^newNumerator / denominator .
	
! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Parte2-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'RABG 4/30/2023 18:26:00'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	denominator isOne ifTrue: [ ^numerator ].
	
	
	aDividend isZero ifTrue: [ ^aDividend ].
	
	^self new initializeWith: numerator over: denominator
	! !