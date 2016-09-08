debug printing
longPrintInstancesOf: aClassOop
	"Scan the heap printing the oops of any and all objects that are instances of aClassOop"
	| oop |
	<api>
	oop := self firstAccessibleObject.
	[oop = nil] whileFalse:
		[(self fetchClassOfNonImm: oop) = aClassOop ifTrue:
			[self longPrintOop: oop; cr].
		 oop := self accessibleObjectAfter: oop]