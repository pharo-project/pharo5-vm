method map
firstMappedPCFor: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	<inline: true>
	^cogMethod cmIsFullBlock
		ifTrue: [cogMethod asUnsignedInteger + cbNoSwitchEntryOffset]
		ifFalse: [cogMethod asUnsignedInteger + cmNoCheckEntryOffset]