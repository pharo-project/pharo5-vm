jit - api
cog: aMethodObj selector: aSelectorOop
	"Attempt to produce a machine code method for the bytecode method
	 object aMethodObj.  N.B. If there is no code memory available do *NOT*
	 attempt to reclaim the method zone.  Certain clients (e.g. ceSICMiss:)
	 depend on the zone remaining constant across method generation."
	<api>
	<returnTypeC: #'CogMethod *'>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	self assert: ((coInterpreter methodHasCogMethod: aMethodObj) not
				or: [(self noAssertMethodClassAssociationOf: aMethodObj) = objectMemory nilObject]).
	"coInterpreter stringOf: aSelectorOop"
	coInterpreter
		compilationBreak: aSelectorOop
		point: (objectMemory lengthOf: aSelectorOop).
	aMethodObj = breakMethod ifTrue: [self halt: 'Compilation of breakMethod'].
	self cppIf: NewspeakVM
		ifTrue: [cogMethod := methodZone findPreviouslyCompiledVersionOf: aMethodObj with: aSelectorOop.
				cogMethod ifNotNil:
					[(coInterpreter methodHasCogMethod: aMethodObj) not ifTrue:
						[self assert: (coInterpreter rawHeaderOf: aMethodObj) = cogMethod methodHeader.
						 cogMethod methodObject: aMethodObj.
						 coInterpreter rawHeaderOf: aMethodObj put: cogMethod asInteger].
					^cogMethod]].
	"If the generators for the alternate bytecode set are missing then interpret."
	(coInterpreter methodUsesAlternateBytecodeSet: aMethodObj)
		ifTrue:
			[(self numElementsIn: generatorTable) <= 256 ifTrue:
				[^nil].
			 bytecodeSetOffset := 256]
		ifFalse:
			[bytecodeSetOffset := 0].
	extA := extB := 0.
	objectRepresentation ensureNoForwardedLiteralsIn: aMethodObj.
	methodObj := aMethodObj.
	cogMethod := self compileCogMethod: aSelectorOop.
	(cogMethod asInteger between: MaxNegativeErrorCode and: -1) ifTrue:
		[cogMethod asInteger = InsufficientCodeSpace ifTrue:
			[coInterpreter callForCogCompiledCodeCompaction].
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