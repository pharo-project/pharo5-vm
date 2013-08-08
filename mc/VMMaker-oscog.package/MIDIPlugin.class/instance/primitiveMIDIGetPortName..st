primitives
primitiveMIDIGetPortName: portNum

	| portName sz nameObj namePtr |
	<var: #portName declareC: 'char portName[256]'>
	<var: #namePtr type: 'char * '>
	self primitive: 'primitiveMIDIGetPortName'
		parameters: #(SmallInteger).

	sz := self cCode: 'sqMIDIGetPortName(portNum, (int) &portName, 255)'.
	nameObj := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: sz.
	interpreterProxy failed ifTrue:[^nil].
	namePtr := nameObj asValue: String .
	self cCode: 'memcpy(namePtr, portName, sz)'.
	^nameObj