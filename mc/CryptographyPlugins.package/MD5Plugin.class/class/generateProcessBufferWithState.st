code generation
generateProcessBufferWithState
	"self generateProcessBufferWithState"
	
	^ String streamContents: [ : stream | 
		stream nextPutAll: self processBufferWithStateHeader.
		self isPlatformBigEndian ifTrue: [ 
			stream cr; tab; nextPutAll: '
	self 
		decode: (self cCoerce: buffer to: #''char*'')
		sizeInIntegers: 16.' ].
		0 to: 63 	do: [ : i | 
			stream nextPutAll: (self round: i) ].
		stream nextPutAll: self processBufferWithStateFooter ]