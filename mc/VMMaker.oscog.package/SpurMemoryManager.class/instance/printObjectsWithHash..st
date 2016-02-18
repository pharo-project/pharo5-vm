debug printing
printObjectsWithHash: hash
	"Scan the heap printing the oops of any and all objects whose hash equals the argument."
	<api>
	self allHeapEntitiesDo:
		[:obj|
		 (self rawHashBitsOf: obj) = hash ifTrue:
			[coInterpreter shortPrintOop: obj; cr]]