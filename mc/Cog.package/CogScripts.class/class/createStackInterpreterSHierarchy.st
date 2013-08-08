separate vm scripts
createStackInterpreterSHierarchy
	"Create the parallel StackInterpreterS, CoInterpreterS tree (without methods).
	 Answer a Dictionary maping source class to dest class with {source. #primitives} -> dest
	 for the added primitives classes."

	| map |
	(Smalltalk classNamed: #StackInterpreterS) ifNotNil:
		[:sis|
		(Object confirm: 'StackInterpreterS exists, nuke?') ifTrue:
			[(ChangeSet superclassOrder: sis withAllSubclasses asArray) reverseDo:
				[:sissc| sissc removeFromSystemUnlogged]]].

	map := Dictionary new.
	(ChangeSet superclassOrder: (StackInterpreter withAllSubclasses
									remove: SchizophrenicClosureFormatStackInterpreter;
									yourself) asArray) do:
		[:sisc| | def |
		def := sisc definition.
		def := sisc == StackInterpreter
				ifTrue: [((def copyReplaceAll: sisc superclass name, ' ' with: ObjectMemory superclass name, ' ')
							copyReplaceAll: 'instanceVariableNames: ''' with: 'instanceVariableNames: ''objectMemory ')
							copyReplaceAll: 'poolDictionaries: ''' with: 'poolDictionaries: ''', (ObjectMemory poolDictionaryNames fold: [:a :b| a, ' ', b]), ' ']
				ifFalse: [def copyReplaceAll: sisc superclass name, ' ' with: sisc superclass name, 'S '].
		def := def copyReplaceAll: sisc name printString with: sisc name printString, 'S'.
		map at: sisc put: (Compiler evaluate: def)].

	map at: {StackInterpreter. #primitives}
		put: (Compiler
				evaluate: 'StackInterpreterS subclass: #StackInterpreterSPrimitives
							instanceVariableNames: ''''
							classVariableNames: ''''
							poolDictionaries: ''''
							category: ''VMMaker-Interpreter''');
		at: {CoInterpreter. #primitives}
		put: (Compiler
				evaluate: 'CoInterpreterS subclass: #CoInterpreterSPrimitives
						instanceVariableNames: ''''
						classVariableNames: ''''
						poolDictionaries: ''''
						category: ''VMMaker-Interpreter''');
		at: {StackInterpreter. #objmem}
		put: (Compiler
				evaluate: 'NewObjectMemory subclass: #NewObjectMemoryS
						instanceVariableNames: ''coInterpreter''
							classVariableNames: ''''
							poolDictionaries: ''''
							category: ''VMMaker-Interpreter''');
		at: {CoInterpreter. #objmem}
		put: (Compiler
				evaluate: 'NewObjectMemoryS subclass: #NewCoObjectMemoryS
						instanceVariableNames: ''''
						classVariableNames: ''''
						poolDictionaries: ''''
						category: ''VMMaker-Interpreter''').

	"reparent subclasses underneath StackInterpreterSPrimitives & CoInterpreterSPrimitives"
	#(StackInterpreterS CoInterpreterS) do:
		[:cn|
		((Smalltalk classNamed: cn) subclasses reject: [:c| c name endsWith: 'Primitives']) do:
			[:sisc| | def |
			def := sisc definition.
			def := def copyReplaceAll: cn, ' ' with: cn, 'Primitives '.
			Compiler evaluate: def]].
	^map