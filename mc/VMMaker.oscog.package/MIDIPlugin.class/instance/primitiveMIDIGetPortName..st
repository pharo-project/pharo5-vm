primitives
primitiveMIDIGetPortName: portNum
	| portName sz nameObj |
	<var: #portName declareC: 'char portName[256]'>
	self primitive: 'primitiveMIDIGetPortName' parameters: #(SmallInteger).

	sz := self sqMIDIGet: portNum Port: portName Name: 255.
	nameObj := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: sz.
	interpreterProxy failed ifTrue: [^nil].
	self mem: (nameObj asValue: String) cp: portName y: sz.
	^nameObj