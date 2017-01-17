C code generator
emitCConstants: constList on: aStream
	"Store the global variable declarations on the given stream."
	constList isEmpty ifTrue: [^self].
	aStream cr; nextPutAll: '/*** Constants ***/'; cr.
	(self sortStrings: constList) do:
		[:varName| | node default value conditional |
		node := constants at: varName.
		node name isEmpty ifFalse:
			["If the definition includes a C comment, or looks like a conditional, take it as is, otherwise convert
			  the value from Smalltalk to C.
			  Allow the class to provide an alternative definition, either of just the value or the whole shebang."
			default := (node value isString
						and: [(node value includesSubString: '/*')
								or: [(node value includesSubString: ' ? ') and: [node value includesSubString: ' : ']]])
							ifTrue: [node value]
							ifFalse: [self cLiteralFor: node value name: varName].
			default = #undefined
				ifTrue: [aStream nextPutAll: '#undef '; nextPutAll: node name; cr]
				ifFalse:
					[conditional := (vmClass ifNil: VMBasicConstants) defineAtCompileTime: node name.
					conditional ifTrue:
						[aStream nextPutAll: '#if !defined('; nextPutAll: node name; nextPutAll: ') /* Allow this to be overridden on the compiler command line */'; cr].
					value := vmClass
								ifNotNil:
									[(vmClass specialValueForConstant: node name default: default)
										ifNotNil: [:specialDef| specialDef]
										ifNil: [default]]
								ifNil: [default].
					value first ~= $# ifTrue:
						[aStream nextPutAll: (conditional ifTrue: ['# define '] ifFalse: ['#define ']); nextPutAll: node name; space].
					aStream nextPutAll: value; cr.
					conditional ifTrue:
						[aStream nextPutAll: '#endif'; cr]]]].
	aStream cr