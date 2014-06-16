debug printing
printForwarders
	<api>
	self allHeapEntitiesDo:
		[:objOop|
		 ((self isForwarded: objOop) and: [(self isFreeObject: objOop) not]) ifTrue:
			[coInterpreter printHex: objOop; cr]]