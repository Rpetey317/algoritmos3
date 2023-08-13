!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryTest methodsFor: 'testing' stamp: 'RABG 6/8/2023 18:21:53'!
test01SummaryForNewAccountIsEmptyWithBalanceZero

	| summary |
	
	summary := AccountSummary for: (ReceptiveAccount new).
	
	self assert: (OrderedCollection newFrom: {'Balance = 0 * pesos'}) equals: summary lines.! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'RABG 6/8/2023 18:19:26'!
test02SummaryForAccountWithOneDepositHasCorrectTransactionAndBalance

	| summary account |
	
	account := ReceptiveAccount new.
	Deposit register: 50*peso on: account.
	summary := AccountSummary for: account.
	
	self 
		assert: (OrderedCollection newFrom: {'Deposito por 50 * pesos'. 'Balance = 50 * pesos'})
		equals: summary lines.! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'RABG 6/9/2023 17:40:20'!
test03SummaryForAccountWithOneWithdrawHasCorrectTransactionAndBalance

	| summary account |
	
	account := ReceptiveAccount new.
	Withdraw register: 50*peso on: account.
	summary := AccountSummary for: account.
	
	self 
		assert: (OrderedCollection newFrom: {'Extraccion por 50 * pesos'. 'Balance = -50 * pesos'})
		equals: summary lines.! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'RABG 6/9/2023 17:42:30'!
test04SummaryForAccountWithOneTransactionDepositHasCorrectTransactionAndBalance

	| summary account anotherAccount|
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer amount: 50 * peso from: anotherAccount to: account. 
	summary := AccountSummary for: account.
	
	self 
		assert: (OrderedCollection newFrom: {'Entrada por transferencia de 50 * pesos'. 'Balance = 50 * pesos'})
		equals: summary lines.! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'RABG 6/9/2023 17:43:07'!
test05SummaryForAccountWithOneTransactionWithdrawHasCorrectTransactionAndBalance

	| summary account anotherAccount|
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer amount: 50 * peso from: account to: anotherAccount. 
	summary := AccountSummary for: account.
	
	self 
		assert: (OrderedCollection newFrom: {'Salida por transferencia de 50 * pesos'. 'Balance = -50 * pesos'})
		equals: summary lines.! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'RABG 6/9/2023 17:43:24'!
test06SummaryForAccountWithMultipleTypesOfTransactionsHasCorrectTransactionsAndBalance

	| summary account anotherAccount expectedSummary |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 50*peso on: account.
	Withdraw register: 20*peso on: account.
	Transfer amount: 10*peso from: account to: anotherAccount.
	Transfer amount: 5*peso from: anotherAccount to: account.
	
	summary := AccountSummary for: account.
	
	expectedSummary := OrderedCollection newFrom:{
						'Deposito por 50 * pesos'. 
						'Extraccion por 20 * pesos'.
						'Salida por transferencia de 10 * pesos'.
						'Entrada por transferencia de 5 * pesos'.
						'Balance = 25 * pesos'}.
	
	self assert: (expectedSummary) equals: summary lines.! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #PortfolioTreeDetailedPrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTreeDetailedPrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreeDetailedPrinterTest methodsFor: 'testing' stamp: 'RABG 6/12/2023 12:44:18'!
test01DetailedTreeReportForEmptyPortfolioIsPortfolioName

	| report |
	
	report := PortfolioTreeDetailedPrinter for: (Portfolio named: 'Empty Portfolio').
	
	self 
		assert: (OrderedCollection newFrom: {'Empty Portfolio'})
		equals: report lines
	! !

!PortfolioTreeDetailedPrinterTest methodsFor: 'testing' stamp: 'RABG 6/12/2023 12:48:45'!
test02DetailedTreeReportForPortfolioWithSingleEmptyAccountGeneratesCorrectly

	| report portfolio account expectedResult |
		
	account := ReceptiveAccount named: 'My Receptive Account'.
	portfolio := Portfolio named: 'My Portfolio' with: account.
	report := PortfolioTreeDetailedPrinter for: (portfolio).
	
	expectedResult := OrderedCollection newFrom: {
								'My Portfolio'.
								'	My Receptive Account'.
								'		Balance = 0 * pesos'
								}.
	self 
		assert: (expectedResult)
		equals: report lines
	! !

!PortfolioTreeDetailedPrinterTest methodsFor: 'testing' stamp: 'RABG 6/12/2023 12:50:36'!
test03DetailedTreeReportForPortfolioWithSingleAccountWithOneDepositGeneratesCorrectly

	| report portfolio account expectedResult |
		
	account := ReceptiveAccount named: 'My Receptive Account'.
	Deposit register: 50*peso on: account.
	portfolio := Portfolio named: 'My Portfolio' with: account.
	report := PortfolioTreeDetailedPrinter for: (portfolio).
	
	expectedResult := OrderedCollection newFrom: {
								'My Portfolio'.
								'	My Receptive Account'.
								'		Deposito por 50 * pesos'.
								'		Balance = 50 * pesos'
								}.
	self 
		assert: (expectedResult)
		equals: report lines
	! !

!PortfolioTreeDetailedPrinterTest methodsFor: 'testing' stamp: 'RABG 6/12/2023 12:51:11'!
test04DetailedTreeReportForPortfolioWithSingleAccountWithOneWithdrawGeneratesCorrectly

	| report portfolio account expectedResult |
		
	account := ReceptiveAccount named: 'My Receptive Account'.
	Withdraw register: 50*peso on: account.
	portfolio := Portfolio named: 'My Portfolio' with: account.
	report := PortfolioTreeDetailedPrinter for: (portfolio).
	
	expectedResult := OrderedCollection newFrom: {
								'My Portfolio'.
								'	My Receptive Account'.
								'		Extraccion por 50 * pesos'.
								'		Balance = -50 * pesos'
								}.
	self 
		assert: (expectedResult)
		equals: report lines
	! !

!PortfolioTreeDetailedPrinterTest methodsFor: 'testing' stamp: 'RABG 6/12/2023 12:52:51'!
test05DetailedTreeReportForPortfolioWithSingleAccountWithOneTransferDepositGeneratesCorrectly

	| report portfolio account anotherAccount expectedResult |
		
	account := ReceptiveAccount named: 'My Receptive Account'.
	anotherAccount := ReceptiveAccount named: 'Other Receptive Account'.
	Transfer amount: 50*peso from: anotherAccount to: account.
	portfolio := Portfolio named: 'My Portfolio' with: account.
	report := PortfolioTreeDetailedPrinter for: (portfolio).
	
	expectedResult := OrderedCollection newFrom: {
								'My Portfolio'.
								'	My Receptive Account'.
								'		Entrada por transferencia de 50 * pesos'.
								'		Balance = 50 * pesos'
								}.
	self 
		assert: (expectedResult)
		equals: report lines
	! !

!PortfolioTreeDetailedPrinterTest methodsFor: 'testing' stamp: 'RABG 6/12/2023 12:53:32'!
test06DetailedTreeReportForPortfolioWithSingleAccountWithOneTransferWithdrawGeneratesCorrectly

	| report portfolio account anotherAccount expectedResult |
		
	account := ReceptiveAccount named: 'My Receptive Account'.
	anotherAccount := ReceptiveAccount named: 'Other Receptive Account'.
	Transfer amount: 50*peso from: account to: anotherAccount.
	portfolio := Portfolio named: 'My Portfolio' with: account.
	report := PortfolioTreeDetailedPrinter for: (portfolio).
	
	expectedResult := OrderedCollection newFrom: {
								'My Portfolio'.
								'	My Receptive Account'.
								'		Salida por transferencia de 50 * pesos'.
								'		Balance = -50 * pesos'
								}.
	self 
		assert: (expectedResult)
		equals: report lines
	! !

!PortfolioTreeDetailedPrinterTest methodsFor: 'testing' stamp: 'RABG 6/12/2023 12:56:46'!
test07DetailedTreeReportForPortfolioWithSingleAccountWithMultipleTransactionsGeneratesCorrectly

	| report portfolio account anotherAccount expectedResult |
		
	account := ReceptiveAccount named: 'My Receptive Account'.
	anotherAccount := ReceptiveAccount named: 'Other Receptive Account'.
	
	Deposit register: 20*peso on: account.
	Withdraw register: 10*peso on: account.
	Transfer amount: 30*peso from: anotherAccount to: account.
	Transfer amount: 50*peso from: account to: anotherAccount.
	
	portfolio := Portfolio named: 'My Portfolio' with: account.
	report := PortfolioTreeDetailedPrinter for: (portfolio).
	
	expectedResult := OrderedCollection newFrom: {
								'My Portfolio'.
								'	My Receptive Account'.
								'		Deposito por 20 * pesos'.
								'		Extraccion por 10 * pesos'.
								'		Entrada por transferencia de 30 * pesos'.
								'		Salida por transferencia de 50 * pesos'.
								'		Balance = -10 * pesos'
								}.
	self 
		assert: (expectedResult)
		equals: report lines
	! !

!PortfolioTreeDetailedPrinterTest methodsFor: 'testing' stamp: 'RABG 6/12/2023 12:58:44'!
test08DetailedTreeReportForPortfolioWithMultipleAccountsWithMultipleTransactionsGeneratesCorrectly

	| report portfolio account anotherAccount expectedResult |
		
	account := ReceptiveAccount named: 'My Receptive Account'.
	anotherAccount := ReceptiveAccount named: 'My Other Receptive Account'.
	
	Deposit register: 20*peso on: account.
	Withdraw register: 10*peso on: anotherAccount.
	
	portfolio := Portfolio named: 'My Portfolio' with: account with: anotherAccount.
	report := PortfolioTreeDetailedPrinter for: (portfolio).
	
	expectedResult := OrderedCollection newFrom: {
								'My Portfolio'.
								'	My Receptive Account'.
								'		Deposito por 20 * pesos'.
								'		Balance = 20 * pesos'.
								'	My Other Receptive Account'.
								'		Extraccion por 10 * pesos'.
								'		Balance = -10 * pesos'
								}.
	self 
		assert: (expectedResult)
		equals: report lines
	! !

!PortfolioTreeDetailedPrinterTest methodsFor: 'testing' stamp: 'RABG 6/12/2023 13:08:31'!
test09DetailedTreeReportForPortfolioWithDifferentIndentLevelsGeneratesCorrectly

	| report familyPortfolio childPortfolio sonAccount daughterAccount dadAccount expectedResult |
	
	dadAccount := ReceptiveAccount named: 'Dads Account'.	
	sonAccount := ReceptiveAccount named: 'Sons Account'.	
	daughterAccount := ReceptiveAccount named: 'Daughters Account'.
	
	Deposit
		register: 20*peso on: dadAccount;
		register: 10*peso on: sonAccount;
		register: 75*peso on: daughterAccount.
		
	childPortfolio := Portfolio named: 'Children Portfolio' with: sonAccount with: daughterAccount.
	familyPortfolio := Portfolio named: 'Family Portfolio' with: dadAccount with: childPortfolio.
	
	report := PortfolioTreeDetailedPrinter for: familyPortfolio.
	
	expectedResult := OrderedCollection newFrom: {
								'Family Portfolio'.
								'	Dads Account'.
								'		Deposito por 20 * pesos'.
								'		Balance = 20 * pesos'.
								'	Children Portfolio'.
								'		Sons Account'.
								'			Deposito por 10 * pesos'.
								'			Balance = 10 * pesos'.
								'		Daughters Account'.
								'			Deposito por 75 * pesos'.
								'			Balance = 75 * pesos'.
								}.
	self 
		assert: (expectedResult)
		equals: report lines
	! !


!classDefinition: #PortfolioTreePrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinterTest methodsFor: 'testing' stamp: 'RABG 6/9/2023 18:59:25'!
test01TreeReportForEmptyPortfolioIsPortfolioName

	| report |
	
	report := PortfolioTreePrinter for: (Portfolio named: 'Empty Portfolio').
	
	self 
		assert: (OrderedCollection newFrom: {'Empty Portfolio'})
		equals: report lines
	! !

!PortfolioTreePrinterTest methodsFor: 'testing' stamp: 'RABG 6/11/2023 22:34:59'!
test02TreeReportForPortfolioWithSingleAccountGeneratesCorrectly

	| report portfolio account |
		
	account := ReceptiveAccount named: 'My Receptive Account'.
	portfolio := Portfolio named: 'My Portfolio' with: account.
	report := PortfolioTreePrinter for: (portfolio).
	
	self 
		assert: (OrderedCollection newFrom: {'My Portfolio'.'	My Receptive Account'})
		equals: report lines
	! !

!PortfolioTreePrinterTest methodsFor: 'testing' stamp: 'RABG 6/11/2023 22:34:51'!
test03TreeReportForPortfolioWithMultipleAccountsGeneratesCorrectly

	| report portfolio account1 account2 expectedResult |
		
	account1 := ReceptiveAccount named: 'My First Account'.	
	account2 := ReceptiveAccount named: 'My Second Account'.
	portfolio := Portfolio named: 'My Portfolio' with: account1 with: account2.
	report := PortfolioTreePrinter for: (portfolio).
	
	expectedResult := OrderedCollection newFrom: {
						'My Portfolio'.
						'	My First Account'.
						'	My Second Account'
						}.
	
	self assert: (expectedResult) equals: report lines
	! !

!PortfolioTreePrinterTest methodsFor: 'testing' stamp: 'RABG 6/11/2023 22:25:18'!
test04TreeReportForOneNestedPortfolioGeneratesCorrectly

	| report portfolio subportfolio account expectedResult |
		
	account := ReceptiveAccount named: 'My Account'.
	subportfolio := Portfolio named: 'My Subportfolio' with: account. 	
	portfolio := Portfolio named: 'My Portfolio' with: subportfolio.
	report := PortfolioTreePrinter for: (portfolio).
	
	expectedResult := OrderedCollection newFrom: {
						'My Portfolio'.
						'	My Subportfolio'.
						'		My Account'
						}.
	
	self assert: (expectedResult) equals: report lines
	! !

!PortfolioTreePrinterTest methodsFor: 'testing' stamp: 'RABG 6/11/2023 23:19:00'!
test05TreeReportForNestedPortfoliosAndAccountsGeneratesCorrectly

	| report portfolio subportfolio expectedResult |
		
	subportfolio := Portfolio named: 'My Subportfolio' with: (ReceptiveAccount named: 'My Subaccount'). 	
	portfolio := Portfolio named: 'My Portfolio' with: subportfolio with: (ReceptiveAccount named: 'My Regular Account').
	report := PortfolioTreePrinter for: (portfolio).
	
	expectedResult := OrderedCollection newFrom: {
						'My Portfolio'.
						'	My Subportfolio'.
						'		My Subaccount'.
						'	My Regular Account'.
						}.
	
	self assert: (expectedResult) equals: report lines
	! !

!PortfolioTreePrinterTest methodsFor: 'testing' stamp: 'RABG 6/12/2023 11:44:57'!
test06TreeReportForMultipleLevelNestedPortfoliosGeneratesCorrectly

	| report parentPortfolio childPortfolio grandchildPortfolio expectedResult |
		
	grandchildPortfolio := Portfolio named: 'My Grandchild Portfolio' with: (ReceptiveAccount named: 'My Subaccount'). 	
	childPortfolio := Portfolio named: 'My Child Portfolio' with: grandchildPortfolio.
	
	parentPortfolio := Portfolio named: 'My Parent Portfolio' 
							with: (ReceptiveAccount named: 'My Account')
							with: childPortfolio.
							
	report := PortfolioTreePrinter for: (parentPortfolio).
	
	expectedResult := OrderedCollection newFrom: {
						'My Parent Portfolio'.
						'	My Account'.
						'	My Child Portfolio'.
						'		My Grandchild Portfolio'.
						'			My Subaccount'
						}.
	
	self assert: (expectedResult) equals: report lines
	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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


!classDefinition: #TransferNetReportTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferNetReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNetReportTest methodsFor: 'testing' stamp: 'RABG 6/9/2023 18:37:37'!
test01TransferNetReportForNewAccountIsEmptyWithBalanceZero

	| report |
	
	report := TransferNetReport for: ReceptiveAccount new.
	
	self assert: (OrderedCollection newFrom: {'Neto de transferencias = 0 * pesos'}) equals: report lines! !

!TransferNetReportTest methodsFor: 'testing' stamp: 'RABG 6/9/2023 18:37:45'!
test02TransferNetReportRegistersATransferDepositCorrectly

	| report account anotherAccount|
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer amount: 50*peso from: anotherAccount to: account.
	
	report := TransferNetReport for: account.
	
	self 
		assert: (OrderedCollection newFrom: {'Neto de transferencias = 50 * pesos'})
		equals: report lines! !

!TransferNetReportTest methodsFor: 'testing' stamp: 'RABG 6/9/2023 18:37:52'!
test03TransferNetReportRegistersATransferWithdrawCorrectly

	| report account anotherAccount|
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer amount: 50*peso from: account to: anotherAccount.
	
	report := TransferNetReport for: account.
	
	self 
		assert: (OrderedCollection newFrom: {'Neto de transferencias = -50 * pesos'})
		equals: report lines! !

!TransferNetReportTest methodsFor: 'testing' stamp: 'RABG 6/9/2023 18:38:02'!
test04TransferNetReportOnlyReportsTransferences

	| report account anotherAccount|
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Deposit register: 20*peso on: account. 
	Transfer amount: 50*peso from: account to: anotherAccount.
	
	report := TransferNetReport for: account.
	
	self 
		assert: (OrderedCollection newFrom: {'Neto de transferencias = -50 * pesos'})
		equals: report lines! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'RABG 6/9/2023 19:01:16'!
name

	^name! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'RABG 6/9/2023 18:12:00'!
transactionsDo: aBlock

	self transactions do: aBlock! !

!Account methodsFor: 'main protocol' stamp: 'RABG 6/9/2023 18:15:07'!
transactionsSelect: selectBlock thenDo: doBlock

	self transactions do: [ :transaction | (selectBlock value: transaction) ifTrue: [ doBlock value: transaction ]]! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'initialization' stamp: 'RABG 6/9/2023 18:49:55'!
initializeWithName: accountName

	self subclassResponsibility 
	! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'RABG 6/9/2023 18:42:33'!
named: accountName

	^self new initializeWithName: accountName! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'RABG 6/9/2023 18:50:54'!
initialize

	self initializeWithName: 'Unnamed Portfolio'! !

!Portfolio methodsFor: 'initialization' stamp: 'RABG 6/9/2023 18:50:34'!
initializeWithName: accountName

	name := accountName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'RABG 6/8/2023 18:05:17'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'RABG 6/9/2023 20:03:44'!
accountsDo: aBlock
	
	accounts do: aBlock ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'reports' stamp: 'RABG 6/12/2023 12:17:35'!
treeReportStringFor: aReport atIndentLevel: indentLevel 

	^aReport portfolioReportStringFor: self atIndentLevel: indentLevel! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error handling' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'RABG 6/9/2023 19:15:41'!
named: portfolioName with: anAccount

	^(self named: portfolioName)
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'RABG 6/9/2023 19:15:35'!
named: portfolioName with: anAccount with: anotherAccount

	^(self named: portfolioName)
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'RABG 6/9/2023 18:51:42'!
initialize

	self initializeWithName: 'Unnamed Receptive Account'! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'RABG 6/9/2023 18:51:23'!
initializeWithName: accountName

	super initialize.
	transactions := OrderedCollection new.
	name := accountName! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'RABG 6/8/2023 18:05:37'!
balance

	^transactions 
		inject: (0 *peso)
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'RABG 6/12/2023 12:17:42'!
treeReportStringFor: aReport atIndentLevel: indentLevel 

	^aReport receptiveAccountReportStringFor: self atIndentLevel: indentLevel ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!classDefinition: #AccountReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountReport methodsFor: 'accessing' stamp: 'RABG 6/9/2023 18:01:02'!
lines

	^lines copy.! !


!AccountReport methodsFor: 'initialization' stamp: 'RABG 6/9/2023 18:05:12'!
initializeFor: anAccount

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'ServiciosFinancieros-Solucion'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'instance creation' stamp: 'RABG 6/8/2023 18:32:00'!
for: anAccount

	^self new initializeFor: anAccount ! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'RABG 6/9/2023 20:02:08'!
initializeFor: anAccount
	
	lines := OrderedCollection new.
	
	anAccount transactionsDo: [ :aTransaction|
		lines add: (aTransaction reportStringFor: self).
		].
	
	lines add: ('Balance = {1}' format:{anAccount balance}).! !


!AccountSummary methodsFor: 'private - Transaction Visits' stamp: 'RABG 6/9/2023 18:27:23'!
depositStringFor: aDeposit

	^'Deposito por {1}' format: {aDeposit value}! !

!AccountSummary methodsFor: 'private - Transaction Visits' stamp: 'RABG 6/9/2023 18:27:18'!
transferenceDepositStringFor: aTransferenceDeposit

	^'Entrada por transferencia de {1}' format: {aTransferenceDeposit value}! !

!AccountSummary methodsFor: 'private - Transaction Visits' stamp: 'RABG 6/9/2023 18:27:36'!
transferenceWithdrawStringFor: aTransferenceWithdraw

	^'Salida por transferencia de {1}' format: {aTransferenceWithdraw value}! !

!AccountSummary methodsFor: 'private - Transaction Visits' stamp: 'RABG 6/9/2023 18:27:40'!
withdrawStringFor: aWithdraw

	^'Extraccion por {1}' format: {aWithdraw value}! !


!classDefinition: #TransferNetReport category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #TransferNetReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNetReport methodsFor: 'initialization' stamp: 'RABG 6/9/2023 18:13:57'!
initializeFor: anAccount
	
	| netBalance |
	
	lines := OrderedCollection new.
	netBalance := 0*peso.
	
	anAccount 
		transactionsSelect: [:aTransaction | aTransaction isKindOf: TransferLeg] 
		thenDo: [ :aTransaction | netBalance := aTransaction affectBalance: netBalance].
	
	lines add: ('Neto de transferencias = {1}' format:{netBalance}).! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'RABG 6/9/2023 20:02:08'!
reportStringFor: aSummary

	self subclassResponsibility! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'RABG 6/9/2023 20:02:08'!
reportStringFor: aSummary

	^aSummary depositStringFor: self. 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'reports' stamp: 'RABG 6/9/2023 20:02:08'!
reportStringFor: aSummary

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'reports' stamp: 'RABG 6/9/2023 20:02:08'!
reportStringFor: aSummary

	^aSummary transferenceDepositStringFor: self! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'reports' stamp: 'RABG 6/9/2023 20:02:08'!
reportStringFor: aSummary

	^aSummary transferenceWithdrawStringFor: self! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'RABG 6/9/2023 20:02:08'!
reportStringFor: aSummary

	^aSummary withdrawStringFor: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #PortfolioTreeReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #PortfolioTreeReport
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreeReport methodsFor: 'private' stamp: 'RABG 6/12/2023 12:31:31'!
trailingTabsFor: indentLevel

	| tabs |
	
	tabs := ''.
	indentLevel timesRepeat: [tabs := tabs, '	'].
	^tabs! !


!PortfolioTreeReport methodsFor: 'initialization' stamp: 'RABG 6/12/2023 12:32:45'!
initializeFor: aPortfolio

	self subclassResponsibility! !


!PortfolioTreeReport methodsFor: 'visits' stamp: 'RABG 6/12/2023 12:32:31'!
portfolioReportStringFor: aPortfolio atIndentLevel: indentLevel

	self subclassResponsibility! !

!PortfolioTreeReport methodsFor: 'visits' stamp: 'RABG 6/12/2023 12:32:36'!
receptiveAccountReportStringFor: aReceptiveAccount atIndentLevel: indentLevel

	self subclassResponsibility! !


!PortfolioTreeReport methodsFor: 'accessing' stamp: 'RABG 6/12/2023 12:32:24'!
lines

	^lines copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreeReport class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreeReport class
	instanceVariableNames: ''!

!PortfolioTreeReport class methodsFor: 'error handling' stamp: 'RABG 6/12/2023 12:30:45'!
cannotGenerateReportErrorDescription

	^'Cannot generate tree report for that type of account'! !

!PortfolioTreeReport class methodsFor: 'error handling' stamp: 'RABG 6/12/2023 12:30:02'!
signalCanNotGenerateReport

	self error: (self cannotGenerateReportErrorDescription)! !


!PortfolioTreeReport class methodsFor: 'instance creation' stamp: 'RABG 6/12/2023 12:26:55'!
assertReportCanBeGeneratedFor: anAccount

	^anAccount isKindOf: Portfolio! !

!PortfolioTreeReport class methodsFor: 'instance creation' stamp: 'RABG 6/12/2023 12:30:59'!
for: anAccount

	(self assertReportCanBeGeneratedFor: anAccount)
			ifFalse: [self signalCanNotGenerateReport].

	^self new initializeFor: anAccount ! !


!classDefinition: #PortfolioTreeDetailedPrinter category: 'ServiciosFinancieros-Solucion'!
PortfolioTreeReport subclass: #PortfolioTreeDetailedPrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreeDetailedPrinter methodsFor: 'visits' stamp: 'RABG 6/12/2023 12:39:43'!
depositStringFor: aDeposit

	^'Deposito por {1}' format: {aDeposit value}! !

!PortfolioTreeDetailedPrinter methodsFor: 'visits' stamp: 'RABG 6/12/2023 12:32:31'!
portfolioReportStringFor: aPortfolio atIndentLevel: indentLevel 

	| trailingTabs stringCollection |
	
	trailingTabs := self trailingTabsFor: indentLevel.
	stringCollection := OrderedCollection newFrom: {trailingTabs, (aPortfolio name)}.
	
	aPortfolio accountsDo: 
		[:account | stringCollection addAll: (account treeReportStringFor: self atIndentLevel: indentLevel + 1)].
		
	^stringCollection ! !

!PortfolioTreeDetailedPrinter methodsFor: 'visits' stamp: 'RABG 6/12/2023 12:48:33'!
receptiveAccountReportStringFor: aReceptiveAccount atIndentLevel: indentLevel 

	| trailingTabs stringCollection |
	
	trailingTabs := self trailingTabsFor: indentLevel.

	stringCollection := OrderedCollection newFrom: {trailingTabs, (aReceptiveAccount name)}. 
	aReceptiveAccount transactionsDo: [:transaction | stringCollection add: (trailingTabs, '	', (transaction reportStringFor: self))].
	
	stringCollection add: (trailingTabs, '	', ('Balance = {1}' format:{aReceptiveAccount balance})).
	^stringCollection! !

!PortfolioTreeDetailedPrinter methodsFor: 'visits' stamp: 'RABG 6/12/2023 12:39:50'!
transferenceDepositStringFor: aTransferenceDeposit

	^'Entrada por transferencia de {1}' format: {aTransferenceDeposit value}! !

!PortfolioTreeDetailedPrinter methodsFor: 'visits' stamp: 'RABG 6/12/2023 12:40:05'!
transferenceWithdrawStringFor: aTransferenceWithdraw

	^'Salida por transferencia de {1}' format: {aTransferenceWithdraw value}! !

!PortfolioTreeDetailedPrinter methodsFor: 'visits' stamp: 'RABG 6/12/2023 12:40:14'!
withdrawStringFor: aWithdraw

	^'Extraccion por {1}' format: {aWithdraw value}! !


!PortfolioTreeDetailedPrinter methodsFor: 'initialization' stamp: 'RABG 6/12/2023 12:32:45'!
initializeFor: aPortfolio

	lines := OrderedCollection newFrom: {aPortfolio name}.
	aPortfolio accountsDo: [:anAccount | lines addAll: (anAccount treeReportStringFor: self atIndentLevel: 1)]
! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
PortfolioTreeReport subclass: #PortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'RABG 6/12/2023 12:32:45'!
initializeFor: aPortfolio

	lines := OrderedCollection newFrom: {aPortfolio name}.
	aPortfolio accountsDo: [:anAccount | lines addAll: (anAccount treeReportStringFor: self atIndentLevel: 1)]
! !



!PortfolioTreePrinter methodsFor: 'visits' stamp: 'RABG 6/12/2023 12:32:31'!
portfolioReportStringFor: aPortfolio atIndentLevel: indentLevel 

	| trailingTabs stringCollection |
	
	trailingTabs := self trailingTabsFor: indentLevel.
	stringCollection := OrderedCollection newFrom: {trailingTabs, (aPortfolio name)}.
	
	aPortfolio accountsDo: 
		[:account | stringCollection addAll: (account treeReportStringFor: self atIndentLevel: indentLevel + 1)].
		
	^stringCollection ! !

!PortfolioTreePrinter methodsFor: 'visits' stamp: 'RABG 6/12/2023 12:32:36'!
receptiveAccountReportStringFor: aReceptiveAccount atIndentLevel: indentLevel 

	| trailingTabs |
	
	trailingTabs := self trailingTabsFor: indentLevel.

	^OrderedCollection newFrom: {trailingTabs, (aReceptiveAccount name)}! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
