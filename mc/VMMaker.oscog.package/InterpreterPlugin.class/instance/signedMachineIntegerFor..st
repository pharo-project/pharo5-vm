API access
signedMachineIntegerFor: value
	<var: #value type: #'sqIntptr_t'>
	<inline: true>
	^interpreterProxy wordSize = 8
		ifTrue: [interpreterProxy signed64BitIntegerFor: value]
		ifFalse: [interpreterProxy signed32BitIntegerFor: value]