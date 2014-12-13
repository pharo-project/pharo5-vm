API access
signedMachineIntegerFor: value
	<var: #value type: #'unsigned long'>
	<inline: true>
	^interpreterProxy bytesPerWord = 8
		ifTrue: [interpreterProxy signed64BitIntegerFor: value]
		ifFalse: [interpreterProxy signed32BitIntegerFor: value]