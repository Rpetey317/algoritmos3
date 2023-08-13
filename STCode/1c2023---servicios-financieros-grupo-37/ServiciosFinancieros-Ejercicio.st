!classDefinition: #AccountTransferenceTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #AccountTransferenceTest
	instanceVariableNames: 'originAccount destinationAccount transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransferenceTest methodsFor: 'tests' stamp: 'RABG 6/5/2023 14:04:23'!
test01TransferenceAffectsBothAccountsAccordingly

	Deposit register: 100 * peso on: originAccount.
	
	AccountTransference register: 50 * peso from: originAccount to: destinationAccount .
	
	self assert: (50 * peso) equals: (originAccount balance).
	self assert: (50 * peso) equals: (destinationAccount balance) 
		

! !

!AccountTransferenceTest methodsFor: 'tests' stamp: 'RABG 6/5/2023 15:09:03'!
test02TransferenceKnowsItsValue
	
	Deposit register: 100 * peso on: originAccount.
	transference := AccountTransference register: 50 * peso from: originAccount to: destinationAccount.
	
	self assert: 50 * peso equals: transference value 
		

! !

!AccountTransferenceTest methodsFor: 'tests' stamp: 'RABG 6/5/2023 15:09:15'!
test03InvolvedAccountsKnowTheirRespectiveTransactions

	| relatedDeposit relatedWithdraw|

	Deposit register: 100 * peso on: originAccount.
	
	transference := AccountTransference register: 50 * peso from: originAccount to: destinationAccount.
	relatedDeposit := transference deposit.
	relatedWithdraw := transference withdrawal.
	
	self assert: (originAccount hasRegistered: relatedWithdraw).
	self assert: (destinationAccount hasRegistered: relatedDeposit).

! !

!AccountTransferenceTest methodsFor: 'tests' stamp: 'RABG 6/5/2023 15:09:21'!
test04TransferenceLegKnowsOtherTransferenceLeg

	| relatedDeposit relatedWithdraw|

	Deposit register: 100 * peso on: originAccount.
	
	transference := AccountTransference register: 50 * peso from: originAccount to: destinationAccount.
	relatedDeposit := transference deposit.
	relatedWithdraw := transference withdrawal.
	
	self assert: relatedDeposit equals: (relatedWithdraw relatedTransaction).
	self assert: relatedWithdraw equals: (relatedDeposit relatedTransaction).			

! !

!AccountTransferenceTest methodsFor: 'tests' stamp: 'RABG 6/5/2023 15:09:32'!
test05TransferenceValueMustBePositive
	
	self
		should: [AccountTransference register: -50 * peso from: originAccount to: destinationAccount]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: AccountTransference invalidTransferenceValueErrorDescription equals: anError messageText]
! !

!AccountTransferenceTest methodsFor: 'tests' stamp: 'RABG 6/5/2023 15:14:41'!
test06AccountCannotTransferToItself
	
	self
		should: [AccountTransference register: 50 * peso from: originAccount to: originAccount ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: AccountTransference cannotTransferToSelfErrorDescription equals: anError messageText]
! !


!AccountTransferenceTest methodsFor: 'setUp/tearDown' stamp: 'RABG 6/5/2023 14:04:23'!
setUp

	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'setUp/tearDown' stamp: 'RABG 6/3/2023 13:34:53'!
setUp

	portfolio := Portfolio new.
	account := ReceptiveAccount new.! !


!PortfolioTest methodsFor: 'testing - basic' stamp: 'RABG 6/3/2023 13:34:49'!
test01NewPortfolioHasZeroBalanceWhenCreated

	self assert: 0 equals: portfolio balance! !

!PortfolioTest methodsFor: 'testing - basic' stamp: 'RABG 6/3/2023 13:34:53'!
test02PortfolioWithZeroBalanceAccountHasZeroBalance

	portfolio add: account.
	
	self assert: 0 equals: portfolio balance! !

!PortfolioTest methodsFor: 'testing - basic' stamp: 'RABG 6/3/2023 13:34:53'!
test03AddingAccountWithPositiveBalanceIncreasesPortfolioBalance

	Deposit register: 50*peso on: account.
	portfolio add: account.
	
	self assert: 50*peso equals: portfolio balance! !

!PortfolioTest methodsFor: 'testing - basic' stamp: 'RABG 6/3/2023 13:34:53'!
test04WithdrawingFromPortfolioAccountDecreasesBalance

	Deposit register: 100*peso on: account.
	portfolio add: account.
	Withdraw register: 50 * peso on: account.
	
	self assert: 50*peso equals: portfolio balance! !

!PortfolioTest methodsFor: 'testing - basic' stamp: 'RABG 6/3/2023 13:34:49'!
test05PortfolioDoesNotKnowUnregisteredTransaction

	| deposit |
	
	deposit := Deposit for: 50*peso.
	
	self deny: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'testing - basic' stamp: 'RABG 6/3/2023 13:34:53'!
test06PortfolioKnowsRegisteredTransaction

	| deposit |

	deposit := Deposit register: 50*peso on: account.
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'testing - basic' stamp: 'RABG 6/3/2023 13:34:53'!
test07PortfolioKnowsItsTransactions

	| deposit withdraw|
	
	portfolio add: account.
	
	deposit := Deposit register: 50*peso on: account.
	withdraw := Withdraw register: 50*peso on: account.

	self assert: 2 equals: (portfolio transactions size).
	self assert: (portfolio transactions includes: deposit).
	self assert: (portfolio transactions includes: withdraw).	! !

!PortfolioTest methodsFor: 'testing - basic' stamp: 'RABG 6/3/2023 13:34:53'!
test08PortfolioWithMultipleAccountsCalculatesBalanceCorrectly

	| anotherAccount |
	
	anotherAccount := ReceptiveAccount new.
	portfolio add: account.
	portfolio add: anotherAccount.	
		
	Deposit register: 100*peso on: account.
	Deposit register: 200*peso on: anotherAccount.
	
	self assert: 300*peso equals: portfolio balance! !

!PortfolioTest methodsFor: 'testing - basic' stamp: 'RABG 6/3/2023 13:34:53'!
test09PortfolioWithMultipleAccountsKnowsRegirestedTransactionsInAllAccounts

	| anotherAccount deposit1 deposit2 |
	
	anotherAccount := ReceptiveAccount new.
	portfolio add: account.
	portfolio add: anotherAccount.	
		
	deposit1 := Deposit register: 100*peso on: account.
	deposit2 := Deposit register: 200*peso on: anotherAccount.
	
	self assert: (portfolio hasRegistered: deposit1).
	self assert: (portfolio hasRegistered: deposit2).! !

!PortfolioTest methodsFor: 'testing - basic' stamp: 'RABG 6/3/2023 13:34:53'!
test10PortfolioWithMultipleAccountsKnowsAllItsTransactions

	| anotherAccount deposit1 deposit2 withdraw1 withdraw2 |

	anotherAccount := ReceptiveAccount new.
	portfolio add: account.
	portfolio add: anotherAccount.	
		
	deposit1 := Deposit register: 100*peso on: account.
	deposit2 := Deposit register: 200*peso on: anotherAccount.
	withdraw1 := Withdraw register: 50*peso on: account.
	withdraw2 := Withdraw register: 70*peso on: anotherAccount.
	
	self assert: 4 equals: (portfolio transactions size).
	self assert: (portfolio transactions includes: deposit1).
	self assert: (portfolio transactions includes: deposit2).
	self assert: (portfolio transactions includes: withdraw1).	
	self assert: (portfolio transactions includes: withdraw2).	! !


!PortfolioTest methodsFor: 'testing -  exceptions' stamp: 'RABG 6/5/2023 15:14:00'!
test11PortfolioCanOnlyAddAcountsAndPortfolios

	portfolio add: ReceptiveAccount new.
	portfolio add: Portfolio new.
	
	self 
		should: [portfolio add: 'not an account']
		raise: Error
		withExceptionDo: [:anError | 
			self assert: portfolio invalidTypeErrorDescription equals: anError messageText
			]
		
 ! !

!PortfolioTest methodsFor: 'testing -  exceptions' stamp: 'RABG 6/3/2023 13:34:49'!
test12CannotAddPortfolioToItself

	self 
		should: [portfolio add: portfolio.]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: portfolio cannotAddSelfErrorDescription equals: (anError messageText)
			]! !

!PortfolioTest methodsFor: 'testing -  exceptions' stamp: 'RABG 6/3/2023 13:34:53'!
test13CannotAddAlreadyAddedAccountToPortfolio

	portfolio add: account.

	self 
		should: [portfolio add: account]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: portfolio accountAlreadyInPortfolioErrorDescription equals: (anError messageText)
			]! !

!PortfolioTest methodsFor: 'testing -  exceptions' stamp: 'RABG 6/3/2023 13:34:53'!
test14CannotAddPortfolioWithDuplicateAccounts

	| anotherPortfolio |
	anotherPortfolio := Portfolio new.

	portfolio add: account.
	anotherPortfolio add: account.

	self 
		should: [portfolio add: anotherPortfolio]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: portfolio accountAlreadyInPortfolioErrorDescription equals: (anError messageText)
			]! !

!PortfolioTest methodsFor: 'testing -  exceptions' stamp: 'RABG 6/3/2023 13:34:49'!
test15CannotAddPortfolioThatIncludesSelf

	| anotherPortfolio |
	anotherPortfolio := Portfolio new.
	
	portfolio add: anotherPortfolio.

	self 
		should: [anotherPortfolio add: portfolio]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: portfolio portfolioIncludesSelfErrorDescription equals: (anError messageText)
			]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'RABG 5/30/2023 20:55:58'!
netValue

	self subclassResponsibility! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'RABG 6/2/2023 17:56:03'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'value' stamp: 'RABG 5/30/2023 20:56:15'!
netValue 

	^self value! !

!Deposit methodsFor: 'value' stamp: 'RABG 5/30/2023 20:55:03'!
value

	^ value! !


!Deposit methodsFor: 'initialization' stamp: 'RABG 6/2/2023 17:57:03'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'RABG 6/2/2023 17:56:07'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'value' stamp: 'RABG 5/30/2023 20:56:30'!
netValue 

	^self value negated! !

!Withdraw methodsFor: 'value' stamp: 'RABG 5/30/2023 20:55:25'!
value

	^ value! !


!Withdraw methodsFor: 'initialization' stamp: 'RABG 6/2/2023 17:55:20'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'RABG 6/2/2023 17:56:12'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountTransference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransference
	instanceVariableNames: 'value deposit withdrawal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransference methodsFor: 'related transactions' stamp: 'RABG 5/30/2023 21:57:02'!
deposit

	^deposit! !

!AccountTransference methodsFor: 'related transactions' stamp: 'RABG 5/30/2023 21:57:14'!
withdrawal

	^withdrawal! !


!AccountTransference methodsFor: 'value' stamp: 'RABG 5/30/2023 21:48:44'!
value

	^value! !


!AccountTransference methodsFor: 'initialization' stamp: 'RABG 6/2/2023 17:54:59'!
for: aValue from: originAccount to: destinationAccount

	value := aValue .
	deposit := TransferenceDeposit register: aValue on: destinationAccount  from: self.
	withdrawal := TransferenceWithdraw register: aValue on: originAccount from: self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransference class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransference class
	instanceVariableNames: ''!

!AccountTransference class methodsFor: 'error handling' stamp: 'RABG 6/5/2023 15:10:45'!
cannotTransferToSelfErrorDescription

	^'Cannot transfer from and to the same account'! !

!AccountTransference class methodsFor: 'error handling' stamp: 'RABG 6/5/2023 15:07:04'!
invalidTransferenceValueErrorDescription

	'Transference value must be positive'! !



!AccountTransference class methodsFor: 'instance creation' stamp: 'RABG 6/5/2023 15:12:22'!
register: aValue from: originAccount to: destinationAccount 
	
	"los chequeos en este caso quedaban mejor aquí que en métodos separados"
	(aValue > 0) ifFalse: [self error: self invalidTransferenceValueErrorDescription].
	(originAccount = destinationAccount) ifTrue: [self error: self cannotTransferToSelfErrorDescription].
	
	^self new for: aValue from: originAccount to: destinationAccount ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'RABG 6/3/2023 13:38:24'!
initialize

	accountsAndPortfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'private - testing' stamp: 'RABG 6/5/2023 13:58:32'!
assertCanBeAdded: anAccountOrPortfolio
	"Tiene chequeos de más, pero queda más legible así en general"

	(self assertIsAccountOrPortfolio: anAccountOrPortfolio) ifFalse: [self error: self invalidTypeErrorDescription].
	(anAccountOrPortfolio = self) ifTrue: [self error: self cannotAddSelfErrorDescription].
	(self includes: anAccountOrPortfolio) ifTrue: [self error: self accountAlreadyInPortfolioErrorDescription ].
	(anAccountOrPortfolio includes: self) ifTrue: [self error: self portfolioIncludesSelfErrorDescription ].
	
	! !

!Portfolio methodsFor: 'private - testing' stamp: 'RABG 6/3/2023 13:37:12'!
assertIsAccountOrPortfolio: anAccountOrPortfolio

	^(anAccountOrPortfolio isKindOf: ReceptiveAccount) 
		or: [anAccountOrPortfolio isKindOf: Portfolio]	! !

!Portfolio methodsFor: 'private - testing' stamp: 'RABG 6/3/2023 13:41:54'!
includes: anAccountOrPortfolioToBeAdded

	^(anAccountOrPortfolioToBeAdded = self) 
		or: [accountsAndPortfolios anySatisfy: [:anAccountOrPortfolio | 
		(anAccountOrPortfolio includes: anAccountOrPortfolioToBeAdded) 
		or: [anAccountOrPortfolioToBeAdded includes: anAccountOrPortfolio]
		]]! !


!Portfolio methodsFor: 'error handling' stamp: 'RABG 6/3/2023 12:17:37'!
accountAlreadyInPortfolioErrorDescription

	^'Account or portfolio already in portfolio'! !

!Portfolio methodsFor: 'error handling' stamp: 'RABG 6/2/2023 19:54:14'!
cannotAddSelfErrorDescription

	^'A portfolio cannot contain itself'! !

!Portfolio methodsFor: 'error handling' stamp: 'RABG 6/2/2023 19:49:21'!
invalidTypeErrorDescription

	^'A portfolio can only contain accounts or other portfolios'! !

!Portfolio methodsFor: 'error handling' stamp: 'RABG 6/3/2023 12:49:23'!
portfolioIncludesSelfErrorDescription

	^'Cannot add portfolio that includes self'! !


!Portfolio methodsFor: 'main protocol' stamp: 'RABG 6/3/2023 13:38:24'!
add: anAccountOrPortfolio

	self assertCanBeAdded: anAccountOrPortfolio.
	accountsAndPortfolios add: anAccountOrPortfolio! !

!Portfolio methodsFor: 'main protocol' stamp: 'RABG 6/3/2023 13:38:40'!
balance

	^accountsAndPortfolios sum: [:anAccountOrPortfolio | anAccountOrPortfolio balance] ifEmpty: [0]! !

!Portfolio methodsFor: 'main protocol' stamp: 'RABG 6/3/2023 13:38:48'!
hasRegistered: aTransaction

	^accountsAndPortfolios anySatisfy: [:anAccountOrPortfolio | anAccountOrPortfolio hasRegistered: aTransaction]
! !

!Portfolio methodsFor: 'main protocol' stamp: 'RABG 6/3/2023 13:39:04'!
transactions

	|transactions|
	
	transactions := OrderedCollection new.
	accountsAndPortfolios do: [:anAccountOrPortfolio | transactions addAll: anAccountOrPortfolio transactions].
	^transactions ! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'private - testing' stamp: 'RABG 6/3/2023 12:56:05'!
includes: anAccountOrPortfolio

	^anAccountOrPortfolio = self! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'RABG 5/30/2023 21:00:11'!
balance

	^transactions sum: [ :aTransaction | aTransaction netValue ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #TransferenceLeg category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferenceLeg
	instanceVariableNames: 'transference value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceLeg methodsFor: 'value' stamp: 'RABG 6/2/2023 17:46:54'!
netValue

	self subclassResponsibility! !

!TransferenceLeg methodsFor: 'value' stamp: 'RABG 6/2/2023 17:49:17'!
relatedTransaction

	self subclassResponsibility ! !

!TransferenceLeg methodsFor: 'value' stamp: 'RABG 6/2/2023 17:47:09'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceLeg class' category: 'ServiciosFinancieros-Ejercicio'!
TransferenceLeg class
	instanceVariableNames: ''!

!TransferenceLeg class methodsFor: 'instance creation' stamp: 'RABG 6/2/2023 17:45:48'!
register: aValue on: anAccount from: aTransference

	| transaction |

	transaction := self for: aValue asPartOf: aTransference.
	anAccount register: transaction.
	
	^transaction
	
! !


!classDefinition: #TransferenceDeposit category: 'ServiciosFinancieros-Ejercicio'!
TransferenceLeg subclass: #TransferenceDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceDeposit methodsFor: 'initialization' stamp: 'RABG 6/2/2023 01:48:20'!
initializeFor: aValue asPartOf: aTransference

	value := aValue.
	transference := aTransference ! !


!TransferenceDeposit methodsFor: 'related transactions' stamp: 'RABG 6/2/2023 01:48:46'!
relatedTransaction

	^transference withdrawal! !


!TransferenceDeposit methodsFor: 'value' stamp: 'RABG 6/2/2023 17:47:37'!
netValue

	^self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferenceDeposit class
	instanceVariableNames: ''!

!TransferenceDeposit class methodsFor: 'instance creation' stamp: 'RABG 6/2/2023 01:54:16'!
for: aValue asPartOf: aTransference

	^ self new initializeFor: aValue asPartOf: aTransference! !


!classDefinition: #TransferenceWithdraw category: 'ServiciosFinancieros-Ejercicio'!
TransferenceLeg subclass: #TransferenceWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceWithdraw methodsFor: 'initialization' stamp: 'RABG 6/2/2023 01:56:16'!
initializeFor: aValue asPartOf: aTransference

	value := aValue.
	transference := aTransference ! !


!TransferenceWithdraw methodsFor: 'related transactions' stamp: 'RABG 6/2/2023 01:56:29'!
relatedTransaction

	^transference deposit ! !


!TransferenceWithdraw methodsFor: 'value' stamp: 'RABG 6/2/2023 17:47:30'!
netValue

	^self value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferenceWithdraw class
	instanceVariableNames: ''!

!TransferenceWithdraw class methodsFor: 'instance creation' stamp: 'RABG 6/2/2023 01:55:22'!
for: aValue asPartOf: aTransference

	^ self new initializeFor: aValue asPartOf: aTransference! !
