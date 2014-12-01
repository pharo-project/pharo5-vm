bootstrap image
findRequiredGlobals
	"Look for the necessary gobal bindings in the prototype methods in the old image.
	 This has to be done early by sending bindingOf: to Smalltalk.  Collect the class
	 hierarchy of all prototypes that access inst vars (non-local prototypes) to check
	 their shapes.  Also find out Metaclass, needed for identifying classes."
	| globals ourMethodClasses classVars bindingOfSym |
	globals := Set new.
	ourMethodClasses := Set new.
	classVars := Dictionary new.
	self prototypeClassNameMetaSelectorMethodDo:
		[:c :m :s :method| | allNonMetaSupers |
		(Smalltalk classNamed: c) ifNotNil:
			[:nonMetaClass|
			allNonMetaSupers := nonMetaClass withAllSuperclasses.
			(method methodClass includesBehavior: SpurBootstrapPrototypes) ifFalse:
				[ourMethodClasses addAll: allNonMetaSupers.
				 globals addAll: (allNonMetaSupers collect: [:sc| sc binding])].
			method literals do:
				[:l|
				(l isVariableBinding
				 and: [l key isSymbol
				 and: [SpurBootstrapPrototypes withAllSubclasses noneSatisfy: [:sbpc| sbpc name == l key]]]) ifTrue:
					[((Smalltalk bindingOf: l key) == l
					  or: [(Undeclared bindingOf: l key) == l])
						ifTrue: [globals add: l]
						ifFalse:
							[self assert: (nonMetaClass bindingOf: l key) == l.
							classVars at: l put: nonMetaClass]]]]].
	globals add: Compiler binding. "For potential reshaping in checkReshapeOf:"
	bindingOfSym := self findSymbol: #bindingOf:.
	self withExecutableInterpreter: oldInterpreter
		do:	[| toBeAdded |
			globals do:
				[:global| | bindingOop |
				(self findSymbol: global key) ifNotNil:
					[:symbolOop|
					bindingOop := self interpreter: oldInterpreter
										object: (oldHeap splObj: 8) "Smalltalk"
										perform: bindingOfSym
										withArguments: {self findSymbol: global key}.
					bindingOop ~= oldHeap nilObject ifTrue:
						[literalMap at: global put: bindingOop]]].
			 toBeAdded := Dictionary new.
			 classVars keysAndValuesDo:
				[:var :class| | val |
				(self findSymbol: var key) "New class inst vars may not yet be interned."
					ifNil: [toBeAdded at: var put: class]
					ifNotNil:
						[:varName|
						val := self interpreter: oldInterpreter
									object: (self oldClassOopFor: class)
									perform: bindingOfSym
									withArguments: {varName}.
						val ~= oldHeap nilObject
							ifTrue: [literalMap at: var put: val]
							ifFalse: [toBeAdded at: var put: class]]].
			"May have to redefine to add missing inst vars and/or add any missing class vars."
			self checkReshapeOf: ourMethodClasses.
			self addMissingClassVars: toBeAdded]