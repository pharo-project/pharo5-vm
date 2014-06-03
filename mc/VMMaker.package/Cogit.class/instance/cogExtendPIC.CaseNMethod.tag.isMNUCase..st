in-line cacheing
cogExtendPIC: cPIC CaseNMethod: caseNMethod tag: caseNTag isMNUCase: isMNUCase
	"Extend the cPIC with the supplied case.  If caseNMethod is cogged dispatch direct to
	 its unchecked entry-point.  If caseNMethod is not cogged, jump to the fast interpreter
	 dispatch, and if isMNUCase then dispatch to fast MNU invocation and mark the cPIC as
	 having the MNU case for cache flushing."
 	<var: #cPIC type: #'CogMethod *'>
	| operand target address size end |
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	coInterpreter
		compilationBreak: cPIC selector
		point: (objectMemory lengthOf: cPIC selector).
	self allocateOpcodes: 5 bytecodes: 0.
	self assert: (objectRepresentation inlineCacheTagIsYoung: caseNTag) not.
	"Caller patches to open pic if caseNMethod is young."
	self assert: (caseNMethod notNil and: [(objectMemory isYoung: caseNMethod) not]).
	(isMNUCase not
	 and: [coInterpreter methodHasCogMethod: caseNMethod])
		ifTrue:
			[operand := 0.
			 target :=  (coInterpreter cogMethodOf: caseNMethod) asInteger + cmNoCheckEntryOffset]
		ifFalse:
			[isMNUCase ifTrue:
				[cPIC cpicHasMNUCase: true].
			 operand := caseNMethod.
			 target := cPIC asInteger
					+ (isMNUCase
						ifTrue: [self sizeof: CogMethod]
						ifFalse: [self interpretOffset - backEnd callInstructionByteSize])].
	self CmpCw: caseNTag R: TempReg.
	self MoveCw: operand R: SendNumArgsReg.
	self JumpLongZero: target.
	self MoveCw: cPIC asInteger R: ClassReg.
	self JumpLong: (self cPICMissTrampolineFor: cPIC cmNumArgs).

	self computeMaximumSizes.
	address := self addressOfEndOfCase: cPIC cPICNumCases - 1 inCPIC: cPIC.
	size := self generateInstructionsAt: address.
	end := self outputInstructionsAt: address.
	processor flushICacheFrom: address to: cPIC asInteger + closedPICSize.
	cPIC cPICNumCases: cPIC cPICNumCases + 1.
	^0