bytecode generator support
genSend: selector numArgs: numArgs sendTable: sendTable
	<inline: false>
	<var: #sendTable type: #'sqInt *'>
	| annotation |
	(objectMemory isYoung: selector) ifTrue:
		[hasYoungReferent := true].
	self assert: needsFrame.
	annotation := self annotationForSendTable: sendTable.
	self assert: (numArgs between: 0 and: 255). "say"
	self assert: (objectMemory addressCouldBeOop: selector).
	self MoveMw: numArgs * objectMemory wordSize r: SPReg R: ReceiverResultReg.
	"Deal with stale super sends; see SpurMemoryManager's class comment."
	(self annotationIsForUncheckedEntryPoint: annotation) ifTrue:
		[objectRepresentation genEnsureOopInRegNotForwarded: ReceiverResultReg scratchReg: TempReg].
	numArgs > 2 ifTrue:
		[self MoveCq: numArgs R: SendNumArgsReg].
	(BytecodeSetHasDirectedSuperSend
	 and: [annotation = IsDirectedSuperSend]) ifTrue:
		[self genMoveConstant: tempOop R: TempReg].
	self MoveCw: selector R: ClassReg.
	self annotate: (self Call: (sendTable at: (numArgs min: NumSendTrampolines - 1)))
		with: annotation.
	self PushR: ReceiverResultReg.
	^0