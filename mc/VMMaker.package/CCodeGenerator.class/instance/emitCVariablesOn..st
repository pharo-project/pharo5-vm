C code generator
emitCVariablesOn: aStream 
	"Store the global variable declarations on the given stream."

	aStream cr; nextPutAll: '/*** Variables ***/'; cr.
	(self sortStrings: variables) do:
		[:var | | varString decl |
		varString := var asString.
		decl := variableDeclarations at: varString ifAbsent: ['sqInt ' , varString].
		decl first == $# "support cgen var: #bytecodeSetSelector declareC: '#define bytecodeSetSelector 0' hack"
			ifTrue:
				[aStream nextPutAll: decl; cr]
			ifFalse:
				[self isGeneratingPluginCode
					ifTrue:
						[varString = 'interpreterProxy'
							ifTrue: "quite special..."
								[self preDeclareInterpreterProxyOn: aStream]
							ifFalse: [(decl beginsWith: 'static') ifFalse:
										[aStream nextPutAll: 'static ']]]
					ifFalse:
						[(vmClass mustBeGlobal: varString)
							ifTrue:
								[(decl beginsWith: 'static ') ifTrue:
									[decl := decl allButFirst: 7]]
							ifFalse:
								[(decl beginsWith: 'static') ifFalse:
									[aStream nextPutAll: 'static ']]].
				aStream
					nextPutAll: decl;
					nextPut: $;;
					cr]].
	aStream cr