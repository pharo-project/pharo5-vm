in-line cacheing
offsetAndSendTableFor: entryPoint annotation: annotation into: binaryBlock
	"Find the relevant sendTable for a linked-send to entryPoint.  Do this based on the
	 annotation.  c.f. annotationForSendTable:"
	<inline: true>
	| offset sendTable |
	<var: #sendTable type: #'sqInt *'>
	annotation = IsSendCall ifTrue:
		[offset := cmEntryOffset.
		 sendTable := ordinarySendTrampolines] ifFalse:
	[(BytecodeSetHasDirectedSuperSend and: [annotation = IsDirectedSuperSend]) ifTrue:
		[offset := cmNoCheckEntryOffset.
		 sendTable := directedSuperSendTrampolines] ifFalse:
	[(NewspeakVM and: [annotation = IsNSSelfSend]) ifTrue:
		[offset := cmEntryOffset.
		 sendTable := selfSendTrampolines] ifFalse:
	[(NewspeakVM and: [annotation = IsNSDynamicSuperSend]) ifTrue:
		[offset := cmEntryOffset.
		 sendTable := dynamicSuperSendTrampolines] ifFalse:
	[self assert: annotation = IsSuperSend.
	 offset := cmNoCheckEntryOffset.
	 sendTable := superSendTrampolines]]]].

	binaryBlock
		value: offset
		value: sendTable