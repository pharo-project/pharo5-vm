API access
signedMachineIntegerFor: value
	<var: #value type: #'sqIntptr_t'>
	<inline: #always>
	^interpreterProxy wordSize = 8
		ifTrue: [interpreterProxy signed64BitIntegerFor: value]
		ifFalse: [interpreterProxy signed32BitIntegerFor: value]