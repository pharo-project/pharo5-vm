debug printing
printForwarders
	<api>
	self allHeapEntitiesDo:
		[:objOop|
		 (self isForwarded: objOop) ifTrue:
			[coInterpreter printHex: objOop; cr]]