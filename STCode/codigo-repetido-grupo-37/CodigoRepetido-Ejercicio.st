!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'aux methods' stamp: 'RABG 4/23/2023 21:52:10'!
assertABook: aBook HasOneCustomer: aCustomer

	self assert: aBook numberOfCustomers = 1.
	self assert: (aBook includesCustomerNamed: aCustomer)! !

!CustomerBookTest methodsFor: 'aux methods' stamp: 'RABG 4/23/2023 21:51:36'!
assertABook: aBook hasTotal: expectedCustomers withActives: expectedActives andSuspended: expectedSuspended

	self assert: expectedCustomers equals: aBook numberOfCustomers.
	self assert: expectedActives equals: aBook numberOfActiveCustomers.
	self assert: expectedSuspended equals: aBook numberOfSuspendedCustomers.
	! !

!CustomerBookTest methodsFor: 'aux methods' stamp: 'RABG 4/23/2023 21:52:27'!
test: aBlock forError: anErrorType andAssert: someAssertions

	[aBlock value. self fail]
		on: anErrorType 
		do: [:anError | someAssertions value: anError].! !

!CustomerBookTest methodsFor: 'aux methods' stamp: 'RABG 4/23/2023 21:52:53'!
timeToEvaluate: aBlock 

	|millisecondsAfterRunning millisecondsBeforeRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning -millisecondsBeforeRunning).! !


!CustomerBookTest methodsFor: 'testing' stamp: 'RABG 4/23/2023 20:28:21'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook millisecondsToRun|
	
	customerBook := CustomerBook new.
	millisecondsToRun := self timeToEvaluate: [customerBook addCustomerNamed: 'John Lennon'].
	
	self assert: millisecondsToRun < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RABG 4/23/2023 20:30:25'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook millisecondsToRun paulMcCartney |

	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.	customerBook addCustomerNamed: paulMcCartney.
	millisecondsToRun := self timeToEvaluate: [customerBook removeCustomerNamed: paulMcCartney.].
	self assert: millisecondsToRun < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RABG 4/23/2023 21:52:27'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self test: [customerBook addCustomerNamed: ''] 
		forError: Error 
		andAssert: [:anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RABG 4/23/2023 21:52:27'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self test: [customerBook removeCustomerNamed: 'Paul McCartney'] 
		forError: NotFound 
		andAssert: [ :anError | 
			self assertABook: customerBook HasOneCustomer: johnLennon ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RABG 4/23/2023 21:51:36'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
		self assertABook: customerBook hasTotal: 1 withActives: 0 andSuspended: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RABG 4/23/2023 21:51:36'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertABook: customerBook hasTotal: 0 withActives: 0 andSuspended: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RABG 4/23/2023 21:52:27'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self test: [customerBook suspendCustomerNamed: 'Ringo Starr'.]
		forError:  CantSuspend
		andAssert: [ :anError | 
			self assertABook: customerBook HasOneCustomer: johnLennon ]

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RABG 4/23/2023 21:52:27'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
		self test:  [customerBook suspendCustomerNamed: johnLennon]
		forError: CantSuspend
		andAssert: [ :anError | 
			self assertABook: customerBook HasOneCustomer: johnLennon ]

! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'customer management' stamp: 'RABG 4/23/2023 23:49:44'!
addCustomerNamed: aName
	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'RABG 4/23/2023 23:44:06'!
findAndRemove: aName from: aCategory

	1 to: aCategory size do: 
		[ :index |
			aName = (aCategory at: index)
				ifTrue: [
					aCategory removeAt: index.
					^ aName 
				] 
		].
	^''! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'RABG 4/23/2023 23:51:22'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'RABG 4/23/2023 23:48:53'!
removeCustomerNamed: aName 
 	| removedCustomer |
	(self includesCustomerNamed: aName) ifFalse: [^ NotFound signal.].
	
	removedCustomer := self findAndRemove: aName from: active .
	(removedCustomer isEmpty) ifFalse: [ ^removedCustomer ].
	
	removedCustomer := self findAndRemove: aName from: suspended .
	 ^removedCustomer .
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'RABG 4/23/2023 23:48:38'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	active remove: aName.
	suspended add: aName
! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
