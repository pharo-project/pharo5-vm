bytecode generator support
annotationForSendTable: sendTable
	"c.f. offsetAndSendTableFor:annotation:into:"
	<inline: true>
	<var: #sendTable type: #'sqInt *'>
	(NewspeakVM and: [sendTable == implicitReceiverSendTrampolines]) ifTrue:
		[self error: 'Unexpected implicit receiver send using dirty send machinery'].
	(NewspeakVM and: [sendTable == outerSendTrampolines]) ifTrue:
		[self error: 'Unexpected outer send using dirty send machinery'].
	(NewspeakVM and: [sendTable == selfSendTrampolines]) ifTrue:
		[^IsNSSelfSend].
	(NewspeakVM and: [sendTable == dynamicSuperSendTrampolines]) ifTrue:
		[^IsNSDynamicSuperSend].
	(BytecodeSetHasDirectedSuperSend and: [sendTable == directedSuperSendTrampolines]) ifTrue:
		[^IsDirectedSuperSend].
	sendTable == superSendTrampolines ifTrue:
		[^IsSuperSend].
	self assert: sendTable == ordinarySendTrampolines.
	^IsSendCall