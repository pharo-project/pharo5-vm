debug printing
printActivationsOf: aMethodObj
	"Scan the heap printing the oops of any and all contexts that refer to anOop"
	<api>
	self allObjectsDo:
		[:obj| 
		 ((self isContextNonImm: obj)
		  and: [aMethodObj = (self fetchPointer: MethodIndex ofObject: obj)]) ifTrue:
			[coInterpreter
				printHex: obj; space; printOopShort: obj; print: ' pc ';
				printHex: (self fetchPointer: InstructionPointerIndex ofObject: obj); cr]]