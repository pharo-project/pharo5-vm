API access
positiveMachineIntegerFor: value
	<var: #value type: #'usqIntptr_t'>
	<inline: #always>
	^interpreterProxy wordSize = 8
		ifTrue: [interpreterProxy positive64BitIntegerFor: value]
		ifFalse: [interpreterProxy positive32BitIntegerFor: value]