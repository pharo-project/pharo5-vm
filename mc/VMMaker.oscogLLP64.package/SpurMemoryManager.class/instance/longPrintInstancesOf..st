debug printing
longPrintInstancesOf: aClassOop
	"Scan the heap printing the oops of any and all objects that are instances of aClassOop"
	<api>
	| classIndex |
	classIndex := self rawHashBitsOf: aClassOop.
	classIndex ~= self isFreeObjectClassIndexPun ifTrue:
		[self longPrintInstancesWithClassIndex: classIndex]