method introspection
picDataFor: descriptor IsBackwardBranch: IsBackwardBranch Mcpc: mcpc Bcpc: bcpc Method: cogMethodArg
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #mcpc type: #'char *'>
	<var: #cogMethodArg type: #'void *'>
	| entryPoint tuple |
	descriptor isNil ifTrue:
		[^0].
	descriptor isBranch ifTrue:
		["it's a branch; conditional?"
		 (descriptor isBranchTrue or: [descriptor isBranchFalse]) ifTrue:
			[tuple := self picDataForConditionalBranch: prevMapAbsPCMcpc at: bcpc + descriptor numBytes.
			 tuple = 0 ifTrue: [^PrimErrNoMemory].
			 objectMemory storePointer: picDataIndex ofObject: picData withValue: tuple.
			 picDataIndex := picDataIndex + 1].
		 ^0].
	"infer it's a send; alas we can't just test the descriptor because of the bloody
	 doubleExtendedDoAnythingBytecode which does sends as well as other things."
	(backEnd isCallPreceedingReturnPC: mcpc asUnsignedInteger) ifFalse:
		[^0].
	entryPoint := backEnd callTargetFromReturnAddress: mcpc asUnsignedInteger.
	entryPoint <= methodZoneBase ifTrue: "send is not linked, or is not a send"
		[^0].
	self targetMethodAndSendTableFor: entryPoint into: "It's a linked send; find which kind."
		[:targetMethod :sendTable|
		 tuple := self picDataForSendTo: targetMethod
					methodClassIfSuper: (sendTable = superSendTrampolines ifTrue:
												[coInterpreter methodClassOf:
													(self cCoerceSimple: cogMethodArg to: #'CogMethod *') methodObject])
					at: mcpc
					bcpc: bcpc + 1].
	tuple = 0 ifTrue: [^PrimErrNoMemory].
	objectMemory storePointer: picDataIndex ofObject: picData withValue: tuple.
	picDataIndex := picDataIndex + 1.
	^0