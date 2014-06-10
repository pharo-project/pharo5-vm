C code generator
emitCConstantsOn: aStream 
	"Store the global variable declarations on the given stream."
	| unused constList |
	unused := constants keys asSet.
	"Don't generate any defines for the externally defined constants,
	 STACKVM, COGVM, COGMTVM et al, unless they're actually used."
	(VMClass class>>#initializeMiscConstants) literalsDo:
		[:lit|
		(lit isVariableBinding and: [lit key isString]) ifTrue:
			[unused add: lit key]].
	methods do:
		[:meth|
		meth declarations keysDo:
			[:v|
			(meth typeFor: v in: self) ifNotNil:
				[:type| unused remove: type ifAbsent: []]].
		unused remove: meth returnType ifAbsent: [].
		meth parseTree nodesDo:
			[:n| n isConstant ifTrue: [unused remove: n name ifAbsent: []]]].
	unused copy do:
		[:const|
		(variableDeclarations anySatisfy: [:value| value includesSubString: const]) ifTrue:
			[unused remove: const ifAbsent: []]].
	"and VMBasicConstants mostBasicConstantNames *must* be taken from interp.h"
	unused addAll: VMBasicConstants mostBasicConstantNames.
	constList := constants keys reject: [:any| unused includes: any].
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
			value := vmClass
						ifNotNil:
							[(vmClass specialValueForConstant: node name default: default)
								ifNotNil: [:specialDef| specialDef]
								ifNil: [default]]
						ifNil: [default].
			value first ~= $# ifTrue:
				[aStream nextPutAll: '#define '; nextPutAll: node name; space].
			aStream nextPutAll: value; cr]].
	aStream cr