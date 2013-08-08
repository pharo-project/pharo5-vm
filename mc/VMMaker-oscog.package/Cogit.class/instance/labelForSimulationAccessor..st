simulation only
labelForSimulationAccessor: blockOrMessageSendOrSelector
	<doNotGenerate>
	^'&', (blockOrMessageSendOrSelector isBlock
			ifTrue: ['block in ', blockOrMessageSendOrSelector method selector]
			ifFalse: [blockOrMessageSendOrSelector isMessageSend
						ifTrue: [blockOrMessageSendOrSelector selector]
						ifFalse: [blockOrMessageSendOrSelector]])