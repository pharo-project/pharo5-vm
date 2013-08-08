C code generation
emitCFunctionPrototype: aStream generator: aCodeGen newlineBeforeName: newlineBeforeName "<Boolean>"
	"Emit a C function header for this method onto the given stream."

	export 
		ifTrue:[aStream nextPutAll: 'EXPORT('; nextPutAll: returnType; nextPut: $)]
		ifFalse:[self isStatic ifTrue:[aStream nextPutAll: 'static '].
				aStream nextPutAll: returnType].
	newlineBeforeName ifTrue: [aStream cr] ifFalse: [aStream space].
	(returnType last = $)
	and: [returnType includesSubString: (aCodeGen cFunctionNameFor: selector)]) ifTrue:
		["Hack fix for e.g. <returnTypeC: 'void (*setInterruptCheckChain(void (*aFunction)(void)))()'>"
		 ^self].
	aStream
		nextPutAll: (aCodeGen cFunctionNameFor: selector);
		nextPut: $(.
	args isEmpty
		ifTrue: [aStream nextPutAll: #void]
		ifFalse:
			[args
				do: [:arg| aStream nextPutAll: (self declarationAt: arg)]
				separatedBy: [ aStream nextPutAll: ', ' ]].
	aStream nextPut: $)