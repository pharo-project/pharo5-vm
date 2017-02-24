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
	(self exclude: aMethodObj selector: aSelectorOop) ifTrue:
		[^nil].
	"In Newspeak we support anonymous accessors and hence tolerate the same
	 method being cogged multiple times.  But only if the method class association is nil."
	NewspeakVM
		ifTrue:
			[(coInterpreter methodHasCogMethod: aMethodObj) ifTrue:
				[cogMethod := coInterpreter cogMethodOf: aMethodObj.
				 self deny: cogMethod selector = aSelectorOop.
				 cogMethod selector = aSelectorOop ifTrue:
					[^cogMethod].
				 (coInterpreter methodClassAssociationOf: aMethodObj) ~= objectMemory nilObject ifTrue:
					[self cCode: 'extern void *firstIndexableField(sqInt)'. "Slang, au natural"
					 self warnMultiple: cogMethod selectors: aSelectorOop.
					^nil]]]
		ifFalse: [self deny: (coInterpreter methodHasCogMethod: aMethodObj)].
	self deny: (objectMemory isOopCompiledMethod: (coInterpreter ultimateLiteralOf: aMethodObj)).
	"coInterpreter stringOf: aSelectorOop"
	coInterpreter
		compilationBreak: aSelectorOop
		point: (objectMemory lengthOf: aSelectorOop)
		isMNUCase: false.
	aMethodObj = breakMethod ifTrue: [self halt: 'Compilation of breakMethod'].
	NewspeakVM ifTrue:
		[cogMethod := methodZone findPreviouslyCompiledVersionOf: aMethodObj with: aSelectorOop.
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
	objectRepresentation ensureNoForwardedLiteralsIn: aMethodObj.
	methodObj := aMethodObj.
	methodHeader := objectMemory methodHeaderOf: aMethodObj.
	receiverTags := objectMemory receiverTagBitsForMethod: methodObj.
	cogMethod := self compileCogMethod: aSelectorOop.
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