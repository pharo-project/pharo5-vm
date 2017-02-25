in-line cacheing
targetMethodAndSendTableFor: entryPoint annotation: annotation into: binaryBlock
	"Evaluate binaryBlock with the targetMethod and relevant send table for a linked-send
	 to entryPoint.  Do so based on the alignment of entryPoint.  N.B.  For Newspeak sends
	 we don't need to distinguish between ceImplicitReceiver and the other sends since
	 ceImplicitReceiver will never appear to be linked, so only three cases here."
	<inline: true>
	| targetMethod sendTable |
	<var: #targetMethod type: #'CogMethod *'>
	<var: #sendTable type: #'sqInt *'>

	annotation = IsSendCall ifTrue:
		[targetMethod := self cCoerceSimple: entryPoint - cmEntryOffset to: #'CogMethod *'.
		 sendTable := ordinarySendTrampolines] ifFalse:
	[(BytecodeSetHasDirectedSuperSend and: [annotation = IsDirectedSuperSend]) ifTrue:
		[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
		 sendTable := directedSuperSendTrampolines] ifFalse:
	[(NewspeakVM and: [annotation = IsNSSelfSend]) ifTrue:
		[targetMethod := self cCoerceSimple: entryPoint - cmEntryOffset to: #'CogMethod *'.
		 sendTable := selfSendTrampolines] ifFalse:
	[(NewspeakVM and: [annotation = IsNSDynamicSuperSend]) ifTrue:
		[targetMethod := self cCoerceSimple: entryPoint - cmEntryOffset to: #'CogMethod *'.
		 sendTable := dynamicSuperSendTrampolines] ifFalse:
	[self assert: annotation = IsSuperSend.
	 targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
	 sendTable := superSendTrampolines]]]].

	binaryBlock
		value: targetMethod
		value: sendTable