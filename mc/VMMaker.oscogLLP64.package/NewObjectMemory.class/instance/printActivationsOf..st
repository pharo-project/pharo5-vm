debug printing
printActivationsOf: aMethodObj
	"Scan the heap printing the oops of any and all contexts that refer to anOop"
	| oop |
	<api>
	oop := self firstAccessibleObject.
	[oop = nil] whileFalse:
		[((self isContextNonImm: oop)
		  and: [aMethodObj = (self fetchPointer: MethodIndex ofObject: oop)]) ifTrue:
			[coInterpreter
				printHex: oop; space; printOopShort: oop; print: ' pc ';
				printHex: (self fetchPointer: InstructionPointerIndex ofObject: oop); cr].
		 oop := self accessibleObjectAfter: oop]