debug printing
printForwarders
	<api>
	self allHeapEntitiesDo:
		[:objOop|
		 (self isUnambiguouslyForwarder: objOop) ifTrue:
			[coInterpreter printHex: objOop; cr]]