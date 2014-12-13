API access
positiveMachineIntegerFor: value
	<var: #value type: #'unsigned long'>
	<inline: true>
	^interpreterProxy bytesPerWord = 8
		ifTrue: [interpreterProxy positive64BitIntegerFor: value]
		ifFalse: [interpreterProxy positive32BitIntegerFor: value]