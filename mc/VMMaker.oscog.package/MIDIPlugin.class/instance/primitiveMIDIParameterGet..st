primitives
primitiveMIDIParameterGet: whichParameter

	|  currentValue |
	"read parameter"
	self primitive: 'primitiveMIDIParameterGet'
		parameters: #(SmallInteger).
	currentValue := self cCode: 'sqMIDIParameterGet(whichParameter)'.
	^currentValue asSmallIntegerObj