bytecode generator support
annotationForSendTable: sendTable
	"c.f. offsetAndSendTableFor:annotation:into:"
	<inline: true>
	<var: #sendTable type: #'sqInt *'>
	(NewspeakVM and: [sendTable == selfSendTrampolines]) ifTrue:
		[^IsNSSelfSend].
	(NewspeakVM and: [sendTable == dynamicSuperSendTrampolines]) ifTrue:
		[^IsNSDynamicSuperSend].
	(NewspeakVM and: [sendTable == implicitReceiverSendTrampolines]) ifTrue:
		[^IsNSImplicitReceiverSend].
	(SistaVM and: [sendTable == directedSuperSendTrampolines]) ifTrue:
		[^IsNSImplicitReceiverSend].
	sendTable == superSendTrampolines ifTrue:
		[^IsSuperSend].
	self assert: sendTable == ordinarySendTrampolines.
	^IsSendCall