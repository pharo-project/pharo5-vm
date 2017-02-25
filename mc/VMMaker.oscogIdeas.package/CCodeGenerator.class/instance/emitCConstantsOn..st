C code generator
emitCConstantsOn: aStream 
	"Store the global variable declarations on the given stream."
	| unused |
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
	self emitCConstants: (constants keys reject: [:any| unused includes: any]) on: aStream