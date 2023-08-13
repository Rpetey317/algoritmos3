!classDefinition: #StackTest category: 'Stack-Preludio'!
TestCase subclass: #StackTest
	instanceVariableNames: 'stack objectToPush'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Preludio'!

!StackTest methodsFor: 'testing' stamp: 'RABG 5/7/2023 20:11:38'!
test01StackShouldBeEmptyWhenCreated

	self assert: stack isEmpty! !

!StackTest methodsFor: 'testing' stamp: 'RABG 5/7/2023 20:21:02'!
test02PushingToStackMakesItNotEmpty

	stack push: objectToPush.
	
	self assert: stack isNotEmpty! !

!StackTest methodsFor: 'testing' stamp: 'RABG 5/7/2023 20:12:27'!
test03PopRemovesItemFromStack

	stack push: objectToPush.
	stack pop.
	
	self assert: stack isEmpty! !

!StackTest methodsFor: 'testing' stamp: 'RABG 5/7/2023 20:13:07'!
test04PopReturnsPoppedObject

	| poppedObject |

	stack push: objectToPush.
	poppedObject := stack pop.
	
	self assert: poppedObject = objectToPush ! !

!StackTest methodsFor: 'testing' stamp: 'RABG 5/7/2023 20:16:16'!
test05TopReturnsLastPushedObject

	| topObject |

	stack push: objectToPush.
	topObject := stack top.
	
	self assert: topObject = objectToPush ! !

!StackTest methodsFor: 'testing' stamp: 'RABG 5/7/2023 20:16:21'!
test06TopDoesNotRemoveItemFromStack

	| topObject |

	stack push: objectToPush.
	topObject := stack top.
	
	self assert: stack isNotEmpty.! !

!StackTest methodsFor: 'testing' stamp: 'RABG 5/7/2023 20:17:41'!
test07PoppingEmptyStackReturnsNil

	| topObject |

	topObject := stack pop.
	
	self assert: topObject isNil.! !

!StackTest methodsFor: 'testing' stamp: 'RABG 5/7/2023 20:17:48'!
test08TopOfEmptyStackIsNil

	| topObject |

	topObject := stack top.
	
	self assert: topObject isNil.! !

!StackTest methodsFor: 'testing' stamp: 'RABG 5/7/2023 20:19:37'!
test09StackBehavesLIFO

	| object1 object2 |

	object1 := 'Argentina'.
	object2 := 'Francia'.
	
	stack push: object1.	
	stack push: object2.
	
	self assert: stack pop = object2. 
	self assert: stack pop = object1. ! !


!StackTest methodsFor: 'setUp' stamp: 'RABG 5/7/2023 20:11:15'!
setUp

	stack := Stack new.
	objectToPush := 'This is an object'! !


!classDefinition: #Node category: 'Stack-Preludio'!
Object subclass: #Node
	instanceVariableNames: 'nextNode item'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Preludio'!

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

!classDefinition: 'Node class' category: 'Stack-Preludio'!
Node class
	instanceVariableNames: ''!

!Node class methodsFor: 'instance creation' stamp: 'rabg 5/5/2023 17:57:39'!
newWithItem: anObject andNext: aNode

	^Node new initializeWithItem: anObject andNext: aNode .! !


!classDefinition: #NullNode category: 'Stack-Preludio'!
Node subclass: #NullNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Preludio'!

!NullNode methodsFor: 'testing' stamp: 'rabg 5/5/2023 17:53:03'!
isNull

	^true.! !


!NullNode methodsFor: 'accessing' stamp: 'rabg 5/5/2023 17:58:39'!
item

	^nil.! !

!NullNode methodsFor: 'accessing' stamp: 'rabg 5/5/2023 17:58:47'!
next

	^self.! !


!classDefinition: #Stack category: 'Stack-Preludio'!
Object subclass: #Stack
	instanceVariableNames: 'topItem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Preludio'!

!Stack methodsFor: 'testing' stamp: 'rabg 5/5/2023 17:52:37'!
isEmpty

	^topItem isNull.! !

!Stack methodsFor: 'testing' stamp: 'rabg 5/5/2023 18:08:05'!
isNotEmpty

	^(topItem isNull) not.! !


!Stack methodsFor: 'initialization' stamp: 'rabg 5/5/2023 17:51:24'!
initialize

	topItem := NullNode new.! !


!Stack methodsFor: 'operations' stamp: 'RABG 5/7/2023 20:13:30'!
pop

	| poppedElement |
	poppedElement := topItem.
	topItem := poppedElement next.
	^poppedElement item.
	! !

!Stack methodsFor: 'operations' stamp: 'rabg 5/5/2023 18:01:55'!
push: anObject

	| newTop |
	newTop := (Node newWithItem: anObject andNext: topItem).
	topItem := newTop ! !

!Stack methodsFor: 'operations' stamp: 'RABG 5/7/2023 20:14:21'!
top

	^topItem item.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stack class' category: 'Stack-Preludio'!
Stack class
	instanceVariableNames: ''!

!Stack class methodsFor: 'error handling' stamp: 'rabg 5/5/2023 18:10:48'!
stackEmptyErrorDescription

	^'Stack is currently empty'! !
