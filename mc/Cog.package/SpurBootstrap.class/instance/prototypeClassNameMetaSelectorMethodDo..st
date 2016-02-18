method prototypes
prototypeClassNameMetaSelectorMethodDo: quaternaryBlock
	"Evaluate aBlock with class name, class is meta, method and selector.
	 For now find methods in class-side category #'method prototypes'.
	 Scheme could be extended to have different protocols for different
	 Squeak/Pharo versions."
	self allMethodPrototypes do:
		[:methodArg| | method className isMeta |
		className := self classNameForPrototypeMethod: (method := methodArg).
		(isMeta := className endsWith: 'class') ifTrue:
			[className := (className allButLast: 5) asSymbol].
		(method pragmaAt: #indirect) ifNotNil:
			[method := (isMeta
							ifTrue: [(Smalltalk classNamed: className) class]
							ifFalse: [Smalltalk classNamed: className]) >> method selector].
		quaternaryBlock
			value: className
			value: isMeta
			value: (self selectorForPrototypeMethod: method)
			value: method]