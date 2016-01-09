C code generator
emitCConstants: constList on: aStream
	"Store the global variable declarations on the given stream."
	constList isEmpty ifTrue: [^self].
	aStream cr; nextPutAll: '/*** Constants ***/'; cr.
	(self sortStrings: constList) do:
		[:varName| | node default value |
		node := constants at: varName.
		node name isEmpty ifFalse:
			["If the definition includes a C comment, take it as is, otherwise convert the value from Smalltalk to C.
			  Allow the class to provide an alternative definition, either of just the value or the whole shebang."
			default := (node value isString and: [node value includesSubString: '/*'])
							ifTrue: [node value]
							ifFalse: [self cLiteralFor: node value name: varName].
			default = #undefined
				ifTrue: [aStream nextPutAll: '#undef '; nextPutAll: node name; cr]
				ifFalse:
					[value := vmClass
								ifNotNil:
									[(vmClass specialValueForConstant: node name default: default)
										ifNotNil: [:specialDef| specialDef]
										ifNil: [default]]
								ifNil: [default].
					value first ~= $# ifTrue:
						[aStream nextPutAll: '#define '; nextPutAll: node name; space].
					aStream nextPutAll: value; cr]]].
	aStream cr