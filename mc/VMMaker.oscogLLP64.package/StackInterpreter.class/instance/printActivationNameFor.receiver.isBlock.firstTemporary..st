debug printing
printActivationNameFor: aMethod receiver: anObject isBlock: isBlock firstTemporary: maybeMessage
	| methClass methodSel classObj |
	<inline: false>
	isBlock ifTrue:
		[self print: '[] in '].
	methClass := self findClassOfMethod: aMethod forReceiver: anObject.
	methodSel := self findSelectorOfMethod: aMethod.
	((objectMemory addressCouldBeOop: anObject)
	 and: [(objectMemory isOopForwarded: anObject) not
	 and: [self addressCouldBeClassObj: (classObj := objectMemory fetchClassOf: anObject)]])
		ifTrue:
			[(classObj = methClass or: [methClass isNil or: [methClass = objectMemory nilObject] "i.e. doits"])
				ifTrue: [self printNameOfClass: classObj count: 5]
				ifFalse:
					[self printNameOfClass: classObj count: 5.
					 self print: '('.
					 self printNameOfClass: methClass count: 5.
					 self print: ')']]
		ifFalse:
			[self cCode: '' inSmalltalk: [self halt].
			 self print: 'INVALID RECEIVER'].
	self print: '>'.
	(objectMemory addressCouldBeOop: methodSel)
		ifTrue:
			[methodSel = objectMemory nilObject
				ifTrue: [self print: '(nil)']
				ifFalse: [self printStringOf: methodSel]]
		ifFalse: [self print: 'INVALID SELECTOR'].
	(methodSel = (objectMemory splObj: SelectorDoesNotUnderstand)
	and: [(objectMemory addressCouldBeObj: maybeMessage)
	and: [(objectMemory fetchClassOfNonImm: maybeMessage) = (objectMemory splObj: ClassMessage)]]) ifTrue:
		["print arg message selector"
		methodSel := objectMemory fetchPointer: MessageSelectorIndex ofObject: maybeMessage.
		self print: ' '.
		self printStringOf: methodSel]