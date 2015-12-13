in-line cacheing
configureCPIC: cPIC Case0: case0CogMethod Case1Method: case1Method tag: case1Tag isMNUCase: isMNUCase numArgs: numArgs delta: addrDelta
	"Configure a copy of the prototype CPIC for a two-case PIC for 
	case0CogMethod and
	case1Method
	case1Tag.
	 The tag for case0CogMethod is at the send site and so doesn't need to be generated.
	 case1Method may be any of
		- a Cog method; jump to its unchecked entry-point
		- a CompiledMethod; jump to the ceInterpretFromPIC trampoline
		- nil; call ceMNUFromPIC
	addDelta is the address change from the prototype to the new CPIC location, needed
	because the loading of the CPIC label at the end may use a literal instead of a pc relative load."
	"self disassembleFrom: cPIC asInteger + (self sizeof: CogMethod) to: cPIC asInteger + closedPICSize"
	<var: #cPIC type: #'CogMethod *'>
	<var: #case0CogMethod type: #'CogMethod *'>
	| operand targetEntry caseEndAddress |
	self assert: case1Method notNil.

	"adjust the call at missOffset, the ceAbortXArgs"
	backEnd rewriteCallAt: cPIC asInteger + missOffset target: (self picAbortTrampolineFor: numArgs).
	
	self assert: (objectRepresentation inlineCacheTagIsYoung: case1Tag) not.
	(isMNUCase not
	 and: [coInterpreter methodHasCogMethod: case1Method])
		ifTrue:
			[operand := 0.
			 targetEntry := (coInterpreter cogMethodOf: case1Method) asInteger + cmNoCheckEntryOffset]
		ifFalse: "We do not scavenge PICs, hence we cannot cache the MNU method if it is in new space."
			[operand := (case1Method isNil or: [objectMemory isYoungObject: case1Method])
							ifTrue: [0]
							ifFalse: [case1Method].
			 targetEntry := case1Method ifNil: [cPIC asInteger + (self sizeof: CogMethod)] ifNotNil: [cPIC asInteger + self picInterpretAbortOffset]].

	"set the jump to the case0 method"
	backEnd rewriteJumpLongAt: cPIC asInteger + firstCPICCaseOffset target: case0CogMethod asInteger + cmNoCheckEntryOffset.

	caseEndAddress := self addressOfEndOfCase: 2 inCPIC: cPIC.

	"update the cpic case"
	self
		rewriteCPICCaseAt: caseEndAddress
		tag: case1Tag
		objRef: operand
		target: (isMNUCase ifTrue: [cPIC asInteger + (self sizeof: CogMethod)] ifFalse: [targetEntry]) asInteger.

	"update the loading of the CPIC address"
	backEnd relocateMethodReferenceBeforeAddress: cPIC asInteger + cPICEndOfCodeOffset - backEnd jumpLongByteSize by: addrDelta.

	"write the final desperate jump to cePICMissXArgs"
	backEnd rewriteJumpLongAt: cPIC asInteger + cPICEndOfCodeOffset target: (self cPICMissTrampolineFor: numArgs).
	^0
	"self disassembleFrom: cPIC + (self sizeof: CogMethod) to: cPIC + closedPICSize - 1."