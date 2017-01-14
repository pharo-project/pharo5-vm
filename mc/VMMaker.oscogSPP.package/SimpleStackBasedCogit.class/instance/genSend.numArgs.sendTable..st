bytecode generator support
genSend: selectorIndex numArgs: numArgs sendTable: sendTable
	<inline: false>
	<var: #sendTable type: #'sqInt *'>
	| annotation |
	self assert: needsFrame.
	annotation := self annotationForSendTable: sendTable.
	self assert: (numArgs between: 0 and: 255). "say"
	self MoveMw: numArgs * objectMemory wordSize r: SPReg R: ReceiverResultReg.
	"Deal with stale super sends; see SpurMemoryManager's class comment."
	(self annotationIsForUncheckedEntryPoint: annotation) ifTrue:
		[objectRepresentation genEnsureOopInRegNotForwarded: ReceiverResultReg scratchReg: TempReg].
	"0 through (NumSendTrampolines - 2) numArgs sends have the arg count implciti in the trampoline.
	 The last send trampoline (NumSendTrampolines - 1) passes numArgs in SendNumArgsReg."
	numArgs >= (NumSendTrampolines - 1) ifTrue:
		[self MoveCq: numArgs R: SendNumArgsReg].
	(BytecodeSetHasDirectedSuperSend
	 and: [annotation = IsDirectedSuperSend]) ifTrue:
		[self genMoveConstant: tempOop R: TempReg].
	self genLoadInlineCacheWithSelector: selectorIndex.
	(self Call: (sendTable at: (numArgs min: NumSendTrampolines - 1))) annotation: annotation.
	self PushR: ReceiverResultReg.
	^0