debug printing
printActivationNameForSelector: aSelector startClass: startClass
	| methClass |
	<inline: false>
	(objectMemory addressCouldBeObj: startClass)
		ifTrue:
			[self findClassForSelector: aSelector
				lookupClass: startClass
				do: [:class| methClass := class].
			(methClass isNil or: [startClass = methClass])
				ifTrue:
					[self printNameOfClass: methClass count: 5.
					 self printChar: $>.
					 methClass ifNil:
						[self printStringOf: (objectMemory splObj: SelectorDoesNotUnderstand).
						 self print: ' ']]
				ifFalse:
					[self printNameOfClass: startClass count: 5.
					 self printChar: $(.
					 self printNameOfClass: methClass count: 5.
					 self printChar: $).
					 self printChar: $>]]
		ifFalse: [self print: 'INVALID CLASS'].
	(objectMemory addressCouldBeOop: aSelector)
		ifTrue:
			[(objectMemory isBytes: aSelector)
				ifTrue: [self printStringOf: aSelector]
				ifFalse: [self printOopShort: aSelector]]
		ifFalse: [self print: 'INVALID SELECTOR']