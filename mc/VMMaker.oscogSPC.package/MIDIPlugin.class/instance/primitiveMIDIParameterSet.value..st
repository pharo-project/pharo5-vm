primitives
primitiveMIDIParameterSet: whichParameter value: newValue

	"write parameter"
	self primitive:'primitiveMIDIParameterSet'
		parameters:#(SmallInteger SmallInteger).
	self cCode: 'sqMIDIParameterSet(whichParameter, newValue)'