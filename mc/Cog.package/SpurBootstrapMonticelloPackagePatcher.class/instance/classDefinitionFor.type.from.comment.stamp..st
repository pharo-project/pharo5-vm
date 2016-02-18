private-accessing
classDefinitionFor: className type: typeSymbol from: definitions comment: commentString stamp: stampString
	| classDef |
	classDef := definitions
					detect: [:d| d isClassDefinition and: [d className = className]]
					ifNone:
						[self assert: (#(BoxedFloat64 SmallFloat64) includes: className).
						 MCClassDefinition new
							initializeWithName: className
							superclassName: #Float
							traitComposition: '{}'
							classTraitComposition: '{}'
							category: 'Kernel-Numbers'
							instVarNames: #()
							classVarNames: #()
							poolDictionaryNames: #()
							classInstVarNames: #()
							type: typeSymbol
							comment: commentString asString
							commentStamp: stampString].
	className == #Character ifTrue:
		[classDef variables removeAllSuchThat:
			[:varDef|
			 varDef isInstanceVariable and: [varDef name = 'value']]].
	classDef instVarNamed: 'type' put: typeSymbol.
	commentString ifNotNil:
		[classDef
			instVarNamed: 'comment' put: commentString;
			instVarNamed: 'commentStamp' put: stampString].
	^MCAddition of: classDef