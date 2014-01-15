debug printing
printActivationNameForMethod: aMethod startClass: startClass isBlock: isBlock firstTemporary: maybeMessage
	| methClass methodSel |
	<inline: false>
	isBlock ifTrue:
		[self print: '[] in '].
	self findSelectorAndClassForMethod: aMethod
		lookupClass: startClass
		do: [:sel :class|
			methodSel := sel.
			methClass := class].
	((self addressCouldBeOop: startClass) and: [methClass notNil])
		ifTrue:
			[startClass = methClass
				ifTrue: [self printNameOfClass: methClass count: 5]
				ifFalse:
					[self printNameOfClass: startClass count: 5.
					 self printChar: $(.
					 self printNameOfClass: methClass count: 5.
					 self printChar: $)]]
		ifFalse: [self print: 'INVALID CLASS'].
	self printChar: $>.
	(objectMemory addressCouldBeOop: methodSel)
		ifTrue:
			[(objectMemory isBytes: methodSel)
				ifTrue: [self printStringOf: methodSel]
				ifFalse: [self printOopShort: methodSel]]
		ifFalse: [self print: 'INVALID SELECTOR'].
	(methodSel = (objectMemory splObj: SelectorDoesNotUnderstand)
	and: [(objectMemory addressCouldBeObj: maybeMessage)
	and: [(objectMemory fetchClassOfNonInt: maybeMessage) = (objectMemory splObj: ClassMessage)]]) ifTrue:
		["print arg message selector"
		methodSel := objectMemory fetchPointer: MessageSelectorIndex ofObject: maybeMessage.
		self print: ' '.
		self printStringOf: methodSel]