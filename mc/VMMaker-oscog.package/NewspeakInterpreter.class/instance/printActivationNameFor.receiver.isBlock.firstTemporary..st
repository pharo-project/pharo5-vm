debug printing
printActivationNameFor: aMethod receiver: anObject isBlock: isBlock firstTemporary: maybeMessage
	| methClass methodSel |
	<inline: false>
	isBlock ifTrue:
		[self print: '[] in '].
	methClass := self findClassOfMethod: aMethod forReceiver: anObject.
	methodSel := self findSelectorOfMethod: aMethod forReceiver: anObject.
	(self addressCouldBeOop: anObject)
		ifTrue:
			[(self fetchClassOf: anObject) = methClass
				ifTrue: [self printNameOfClass: methClass count: 5]
				ifFalse:
					[self printNameOfClass: (self fetchClassOf: anObject) count: 5.
					 self print: '('.
					 self printNameOfClass: methClass count: 5.
					 self print: ')']]
		ifFalse: [self print: 'INVALID RECEIVER'].
	self print: '>'.
	(self addressCouldBeOop: methodSel)
		ifTrue:
			[methodSel = self nilObject
				ifTrue: [self print: '?']
				ifFalse: [self printStringOf: methodSel]]
		ifFalse: [self print: 'INVALID SELECTOR'].
	(methodSel = (self splObj: SelectorDoesNotUnderstand)
	and: [(self addressCouldBeObj: maybeMessage)
	and: [(self fetchClassOf: maybeMessage) = (self splObj: ClassMessage)]]) ifTrue:
		["print arg message selector"
		methodSel := self fetchPointer: MessageSelectorIndex ofObject: maybeMessage.
		self print: ' '.
		self printStringOf: methodSel]