debug printing
longPrintInstancesWithClassIndex: classIndex
	"Scan the heap printing any and all objects whose classIndex equals the argument."
	<api>
	<inline: false>
	self allHeapEntitiesDo:
		[:obj|
		 (self classIndexOf: obj) = classIndex ifTrue:
			[coInterpreter longPrintOop: obj; cr]]