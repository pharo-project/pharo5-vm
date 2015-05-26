C code generator
emitGlobalCVariablesOn: aStream
	"Store the global variable declarations on the given stream."

	aStream cr; nextPutAll: '/*** Global Variables ***/'; cr.
	
	(self sortStrings: (variables select: [:v| vmClass mustBeGlobal: v])) do:
		[:var | | varString decl |
		varString := var asString.
		decl := variableDeclarations at: varString ifAbsent: ['sqInt ' , varString].
		decl first == $# "support cgen var: #bytecodeSetSelector declareC: '#define bytecodeSetSelector 0' hack"
			ifTrue:
				[aStream nextPutAll: decl; cr]
			ifFalse:
				[(decl includesSubString: ' private ') ifFalse: "work-around hack to prevent localization of variables only referenced once."
					[(decl beginsWith: 'static') ifFalse: [aStream nextPutAll: 'VM_EXPORT '].
					(decl includes: $=) ifTrue:
						[decl := decl copyFrom: 1 to: (decl indexOf: $=) - 1].
					aStream
						nextPutAll: decl;
						nextPut: $;;
						cr]]].
	aStream cr