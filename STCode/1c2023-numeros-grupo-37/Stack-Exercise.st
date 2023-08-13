!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: 'stack limitedStack objectToPush'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'setUp' stamp: 'RABG 5/7/2023 20:01:50'!
setUp

	stack := OOStack new.
	limitedStack := OOLimitedStack withMax: 3.
	objectToPush := 'something'! !


!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:01:50'!
test01StackShouldBeEmptyWhenCreated

	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:01:50'!
test02PushAddElementsToTheStack

	stack push: objectToPush .
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:01:50'!
test03PopRemovesElementsFromTheStack

	stack push: objectToPush .
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:01:50'!
test04PopReturnsLastPushedObject

	stack push: objectToPush .
	
	self assert: stack pop = objectToPush ! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:01:50'!
test05StackBehavesLIFO

	| firstPushedObject secondPushedObject |

	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	
	self assert: stack isEmpty 
	
	! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:01:50'!
test06TopReturnsLastPushedObject

	stack push: objectToPush .
	
	self assert: stack top = objectToPush .
	
	! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:01:50'!
test07TopDoesNotRemoveObjectFromStack

	stack push: objectToPush.
	
	self assert: stack size = 1.
	
	stack top.
	
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:01:50'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	self
		should: [ stack pop ]		
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:01:50'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	stack push: objectToPush .
	
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:01:50'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:01:30'!
test11CanPushToNotFullLimitedStack

	limitedStack push: objectToPush .
	
	self deny: limitedStack isEmpty.
	
		
! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:03:10'!
test12CanPushToLimitedStackUntilFull

	limitedStack push: 'object1'.
	limitedStack push: 'object2'.	
	limitedStack push: 'object3'.
	
	
	self assert: (limitedStack size = 3).
	
		
! !

!OOStackTest methodsFor: 'test' stamp: 'RABG 5/7/2023 20:05:25'!
test13CanNotPushToFullLimitedStack

	limitedStack push: 'object1'.
	limitedStack push: 'object2'.	
	limitedStack push: 'object3'.
	
	self
		should: [ limitedStack push: 'too many objects!!']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOLimitedStack maxCapacityReachedErrorDescription ]
	
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'collection finder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RABG 5/6/2023 00:36:34'!
test01PrefixMatchesCorrectly

	| matches |
	matches := collection find: 'Hello'.
	self assert: (matches size = 1).
	self assert: matches includes: 'Hello, World!!'.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RABG 5/6/2023 00:36:39'!
test02PrefixNotInCollectionGivesNoMatches

	| matches |
	matches := collection find: 'Tacos!!'.
	self assert: matches isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RABG 5/6/2023 00:36:54'!
test03PrefixMatchesMultipleTimesCorrectly

	| matches |
	matches := collection find: 'Winter'.
	self assert: (matches size = 2).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RABG 5/6/2023 00:36:58'!
test04PrefixMatchesRepeatedSentencesCorrectly

	| matches |
	matches := collection find: 'This'.
	self assert: (matches size = 3).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RABG 5/6/2023 00:37:04'!
test05PrefixLongerThanFullStringDoesNotMatch

	| coll match1 match2 |
	coll := SentenceFinderByPrefix with: {'SemáforoDeMaipú'}.

	match1 := coll find: 'SemáforoDeMaipú'.
	match2  := coll find: 'SemáforoDeMaipúYCorrientes'.
	self assert: (match1 size = 1).
	self assert: (match2 size = 0).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RABG 5/6/2023 00:20:57'!
test06SearchIsCaseSensitive

	| matches |
	matches := collection find: 'this'.
	self assert: (matches isEmpty).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RABG 5/6/2023 00:21:19'!
test07CanNotSearchEmptyPrefix

	self
		should: [ collection find: '']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidSearchPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RABG 5/6/2023 00:21:28'!
test08CanNotSearchPrefixWithBlankSpace

	self
		should: [ collection find: 'Hel lo']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidSearchPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RABG 5/6/2023 00:20:29'!
test09ThereAreNoMatchesInEmptyCollection

	| matches emptyCollection|
	emptyCollection := SentenceFinderByPrefix with: {}.
	matches := emptyCollection find: 'Hello'.
	self assert: (matches isEmpty).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RABG 5/6/2023 00:36:27'!
test10FinderAlwaysSearchesInSameOrder

	| match1 match2 coll |
	
	coll := SentenceFinderByPrefix with:{'item1'. 'item2'. 'item3'. 'item4'}.
	match1 := coll find: 'item'.
	match2 := coll find: 'item'.
	
	self assert: (match1 hasEqualElements: match2).! !


!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'RABG 5/6/2023 00:26:53'!
setUp

	| coll |
	
	coll := {
		'Hello, World!!'.
		'Winter is coming'.
		'Winter is wonderful'.
		'winter is coming'.
		'a Winter night'.
		' Winter is coming'.
		'This is a sentence'.	
		'This is a sentence'.
		'This is another sentence'.
		
		'SemáforoDeMaipú'
	}.
	
	collection := SentenceFinderByPrefix with: coll.
	
	! !


!classDefinition: #Node category: 'Stack-Exercise'!
Object subclass: #Node
	instanceVariableNames: 'nextNode item'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Node methodsFor: 'testing' stamp: 'rabg 5/5/2023 17:52:53'!
isNull

	^false.! !


!Node methodsFor: 'accessing' stamp: 'rabg 5/5/2023 17:53:36'!
item

	^item ! !

!Node methodsFor: 'accessing' stamp: 'rabg 5/5/2023 17:53:52'!
next

	^nextNode ! !


!Node methodsFor: 'initialization' stamp: 'rabg 5/5/2023 17:49:32'!
initializeWithItem: anObject andNext: aNode
	
	item  := anObject.
	nextNode := aNode.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Node class' category: 'Stack-Exercise'!
Node class
	instanceVariableNames: ''!

!Node class methodsFor: 'instance creation' stamp: 'rabg 5/5/2023 17:57:39'!
newWithItem: anObject andNext: aNode

	^Node new initializeWithItem: anObject andNext: aNode .! !


!classDefinition: #NullNode category: 'Stack-Exercise'!
Node subclass: #NullNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullNode methodsFor: 'testing' stamp: 'rabg 5/5/2023 17:53:03'!
isNull

	^true.! !


!NullNode methodsFor: 'accessing' stamp: 'rabg 5/5/2023 18:28:31'!
item

	self error: OOStack stackEmptyErrorDescription ! !

!NullNode methodsFor: 'accessing' stamp: 'rabg 5/5/2023 18:28:42'!
next

	self error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topItem size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'rabg 5/5/2023 17:52:37'!
isEmpty

	^topItem isNull.! !

!OOStack methodsFor: 'testing' stamp: 'rabg 5/5/2023 19:48:54'!
isNotEmpty

	^self isEmpty not.! !


!OOStack methodsFor: 'initialization' stamp: 'RABG 5/7/2023 19:22:38'!
initialize

	topItem := NullNode new.
	size := 0.! !


!OOStack methodsFor: 'operations' stamp: 'RABG 5/7/2023 19:25:44'!
pop

	| poppedElement |
	poppedElement := topItem.
	topItem := poppedElement next.
	size := size - 1.

	^poppedElement item.
	! !

!OOStack methodsFor: 'operations' stamp: 'RABG 5/7/2023 19:25:16'!
push: anObject

	| newTop |
	newTop := (Node newWithItem: anObject andNext: topItem).
	topItem := newTop.
	size := size + 1.! !

!OOStack methodsFor: 'operations' stamp: 'RABG 5/7/2023 19:26:55'!
size
	^size! !

!OOStack methodsFor: 'operations' stamp: 'rabg 5/5/2023 18:25:27'!
top

	^topItem item
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error handling' stamp: 'rabg 5/5/2023 18:10:48'!
stackEmptyErrorDescription

	^'Stack is empty'! !


!classDefinition: #OOLimitedStack category: 'Stack-Exercise'!
OOStack subclass: #OOLimitedStack
	instanceVariableNames: 'limit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOLimitedStack methodsFor: 'operations' stamp: 'RABG 5/7/2023 20:05:25'!
push: anItem

	(self size >= limit) ifTrue: [
		self error: self class maxCapacityReachedErrorDescription.
	].
	super push: anItem ! !


!OOLimitedStack methodsFor: 'initialization' stamp: 'RABG 5/7/2023 19:30:07'!
initializeWith: aMaxSize

	limit := aMaxSize.
	super initialize ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOLimitedStack class' category: 'Stack-Exercise'!
OOLimitedStack class
	instanceVariableNames: ''!

!OOLimitedStack class methodsFor: 'instance creation' stamp: 'RABG 5/7/2023 19:29:20'!
withMax: aMaxSize

	^self new initializeWith: aMaxSize! !


!OOLimitedStack class methodsFor: 'error handling' stamp: 'RABG 5/7/2023 20:05:25'!
maxCapacityReachedErrorDescription

	^'Limited stack is currently full'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'rabg 5/5/2023 19:11:13'!
initializeWith: aStringCollection

	sentences := OOStack new.
	aStringCollection do:[:aSentence | sentences push: aSentence ].! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'rabg 5/5/2023 20:36:29'!
checkPrefix: aPrefix

	(aPrefix isEmpty or: [(aPrefix findString: ' ' startingAt: 1) ~= 0])
	ifTrue: [
		self error: self class invalidSearchPrefixErrorDescription .
	].
	 ! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'RABG 5/6/2023 00:23:05'!
find: aPrefix

	| searched matched |
	
	self checkPrefix: aPrefix.
	
	searched := OOStack new.
	matched := OrderedCollection new .
	[sentences isNotEmpty] whileTrue: [ | current |
		current := sentences pop.
		(current is: aPrefix substringAt: 1) ifTrue: [
			matched add: current
			].
		searched push: current
	].
	
	[searched isNotEmpty] whileTrue: [ | current |
		current := searched pop.
		sentences push: current.
	].

	^matched.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error handling' stamp: 'rabg 5/5/2023 20:33:57'!
invalidSearchPrefixErrorDescription

	^'Prefix can not be empty'! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'rabg 5/5/2023 19:13:10'!
with: aStringCollection

	^self new initializeWith: aStringCollection. ! !
