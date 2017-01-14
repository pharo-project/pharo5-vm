jit - api
cogFullBlockMethod: aMethodObj numCopied: numCopied
	"Attempt to produce a machine code method for the bytecode method
	 object aMethodObj.  N.B. If there is no code memory available do *NOT*
	 attempt to reclaim the method zone.  Certain clients (e.g. ceSICMiss:)
	 depend on the zone remaining constant across method generation."
	<api>
	<option: #SistaV1BytecodeSet>
	<returnTypeC: #'CogMethod *'>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	(self exclude: aMethodObj) ifTrue:
		[^nil].
	self deny: (coInterpreter methodHasCogMethod: aMethodObj).
	self assert: (objectMemory isOopCompiledMethod: (coInterpreter ultimateLiteralOf: aMethodObj)).
	aMethodObj = breakMethod ifTrue: [self halt: 'Compilation of breakMethod'].
	"If the generators for the alternate bytecode set are missing then interpret."
	(coInterpreter methodUsesAlternateBytecodeSet: aMethodObj)
		ifTrue:
			[(self numElementsIn: generatorTable) <= 256 ifTrue:
				[^nil].
			 bytecodeSetOffset := 256]
		ifFalse:
			[bytecodeSetOffset := 0].
	objectRepresentation ensureNoForwardedLiteralsIn: aMethodObj.
	methodObj := aMethodObj.
	methodHeader := objectMemory methodHeaderOf: aMethodObj.
	cogMethod := self compileCogFullBlockMethod: numCopied.
	(cogMethod asInteger between: MaxNegativeErrorCode and: -1) ifTrue:
		[cogMethod asInteger = InsufficientCodeSpace ifTrue:
			[coInterpreter callForCogCompiledCodeCompaction].
		 self maybeFreeCounters.
		 "Right now no errors should be reported, so nothing more to do."
		 "self reportError: (self cCoerceSimple: cogMethod to: #sqInt)."
		 ^nil].
	"self cCode: ''
		inSmalltalk:
			[coInterpreter printCogMethod: cogMethod.
			 ""coInterpreter symbolicMethod: aMethodObj.""
			 self assertValidMethodMap: cogMethod."
			 "self disassembleMethod: cogMethod."
			 "printInstructions := clickConfirm := true""]."
	^cogMethod