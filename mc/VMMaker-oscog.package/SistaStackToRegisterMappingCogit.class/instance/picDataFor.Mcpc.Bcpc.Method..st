method introspection
picDataFor: descriptor Mcpc: mcpc Bcpc: bcpc Method: cogMethodArg
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #mcpc type: #'char *'>
	<var: #cogMethodArg type: #'void *'>
	| entryPoint offset targetMethod tuple |
	<var: #targetMethod type: #'CogMethod *'>
	descriptor isNil ifTrue:
		[^0].
	descriptor isBranch ifFalse: "infer it's a send"
		[self assert: (backEnd isCallPreceedingReturnPC: mcpc asUnsignedInteger).
		 entryPoint := backEnd callTargetFromReturnAddress: mcpc asUnsignedInteger.
		 entryPoint <= methodZoneBase ifTrue: "send is not linked"
			[^0].
		"It's a linked send; find which kind."
		offset := (entryPoint bitAnd: entryPointMask) = checkedEntryAlignment
						ifTrue: [cmEntryOffset]
						ifFalse: [cmNoCheckEntryOffset].
		 targetMethod := self cCoerceSimple: entryPoint - offset to: #'CogMethod *'.
		 tuple := self picDataForSendTo: targetMethod at: mcpc bcpc: bcpc.
		 tuple = 0 ifTrue: [^PrimErrNoMemory].
		 objectMemory storePointer: picDataIndex ofObject: picData withValue: tuple.
		 picDataIndex := picDataIndex + 1.
		 ^0].
	"it's a branch; conditional?"
	(descriptor isBranchTrue or: [descriptor isBranchFalse]) ifTrue:
		[tuple := self picDataForConditionalBranch: prevMapAbsPCMcpc at: bcpc.
		 tuple = 0 ifTrue: [^PrimErrNoMemory].
		 objectMemory storePointer: picDataIndex ofObject: picData withValue: tuple.
		 picDataIndex := picDataIndex + 1.
		 ^0].
	^0