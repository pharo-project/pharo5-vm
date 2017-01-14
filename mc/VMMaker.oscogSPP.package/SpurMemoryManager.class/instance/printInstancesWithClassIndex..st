debug printing
printInstancesWithClassIndex: classIndex
	"Scan the heap printing the oops of any and all objects whose classIndex equals the argument."
	<api>
	<inline: false>
	self allHeapEntitiesDo:
		[:obj|
		 (self classIndexOf: obj) = classIndex ifTrue:
			[coInterpreter printHex: obj; cr]]