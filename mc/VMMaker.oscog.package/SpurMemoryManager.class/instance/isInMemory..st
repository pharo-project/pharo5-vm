plugin support
isInMemory: address 
	"Answer if the given address is in ST object memory."
	^(self isInNewSpace: address)
	  or: [segmentManager isInSegments: address]