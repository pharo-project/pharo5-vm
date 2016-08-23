in-line cacheing
configureMNUCPIC: cPIC methodOperand: methodOperand numArgs: numArgs delta: addrDelta
	"Configure a copy of the prototype CPIC for a one-case MNU CPIC that calls ceMNUFromPIC for
	 case0Tag The tag for case0 is at the send site and so doesn't need to be generated.
	 addDelta is the address change from the prototype to the new CPIC location, needed
	 because the loading of the CPIC label at the end may be a literal instead of a pc-relative load."
	<var: #cPIC type: #'CogMethod *'>
	| operand |

	"adjust the jump at missOffset, the ceAbortXArgs"
	backEnd rewriteCallAt: cPIC asInteger + missOffset target: (self picAbortTrampolineFor: numArgs).
	
	"We do not scavenge PICs, hence we cannot cache the MNU method if it is in new space."
	operand := (methodOperand isNil or: [objectMemory isYoungObject: methodOperand])
					ifTrue: [0]
					ifFalse: [methodOperand].
	"set the jump to the case0 method"
	backEnd rewriteJumpLongAt: cPIC asInteger + firstCPICCaseOffset target: cPIC asInteger + (self sizeof: CogMethod) .

	backEnd storeLiteral: operand beforeFollowingAddress: cPIC asInteger + firstCPICCaseOffset - backEnd jumpLongByteSize.

	"rewrite the final desperate jump to cePICMissXArgs"
	backEnd rewriteJumpLongAt: cPIC asInteger + cPICEndOfCodeOffset target: (self cPICMissTrampolineFor: numArgs).	

	"update the loading of the CPIC label address"
	backEnd relocateMethodReferenceBeforeAddress: cPIC asInteger + cPICEndOfCodeOffset - backEnd jumpLongByteSize by: addrDelta.

	"finally, rewrite the jump 3 instr before firstCPICCaseOffset to jump to the end of case 2, missing the actual case"
	self rewriteCPIC: cPIC caseJumpTo: (self addressOfEndOfCase: 2 inCPIC: cPIC). 

	^0