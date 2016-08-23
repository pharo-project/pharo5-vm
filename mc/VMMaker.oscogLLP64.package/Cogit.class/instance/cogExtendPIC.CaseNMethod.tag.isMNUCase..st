in-line cacheing
cogExtendPIC: cPIC CaseNMethod: caseNMethod tag: caseNTag isMNUCase: isMNUCase
	"Extend the cPIC with the supplied case.  If caseNMethod is cogged dispatch direct to
	 its unchecked entry-point.  If caseNMethod is not cogged, jump to the fast interpreter
	 dispatch, and if isMNUCase then dispatch to fast MNU invocation and mark the cPIC as
	 having the MNU case for cache flushing."
 	<var: #cPIC type: #'CogMethod *'>
	| operand target address |

	coInterpreter
		compilationBreak: cPIC selector
		point: (objectMemory numBytesOf: cPIC selector)
		isMNUCase: isMNUCase.

	self assert: (objectRepresentation inlineCacheTagIsYoung: caseNTag) not.
	"Caller patches to open pic if caseNMethod is young."
	self assert: (caseNMethod notNil and: [(objectMemory isYoung: caseNMethod) not]).
	(isMNUCase not and: [coInterpreter methodHasCogMethod: caseNMethod])
		ifTrue: "this isn't an MNU and we have an already cogged method to jump to"
			[operand := 0.
			 target := (coInterpreter cogMethodOf: caseNMethod) asInteger + cmNoCheckEntryOffset]
		ifFalse: 
			[operand := caseNMethod.
			 isMNUCase
				ifTrue: "this is an MNU so tag the CPIC header and setup a jump to the MNUAbort"
					[cPIC cpicHasMNUCase: true.
					 target := cPIC asInteger + (self sizeof: CogMethod)]
				ifFalse: "setup a jump to the interpretAborth so we can cog the target method"
					[target := cPIC asInteger + self picInterpretAbortOffset]].

	"find the end address of the new case"
	address := self addressOfEndOfCase: cPIC cPICNumCases +1 inCPIC: cPIC.
	
	self rewriteCPICCaseAt: address tag: caseNTag objRef: operand target: target.

	"finally, rewrite the jump 3 instr  before firstCPICCaseOffset to jump to the beginning of this new case"
	self rewriteCPIC: cPIC caseJumpTo: address - cPICCaseSize. 

	processor flushICacheFrom: cPIC asUnsignedInteger to: cPIC asUnsignedInteger + closedPICSize.
	"update the header flag for the number of cases"
	cPIC cPICNumCases: cPIC cPICNumCases + 1.
	^0