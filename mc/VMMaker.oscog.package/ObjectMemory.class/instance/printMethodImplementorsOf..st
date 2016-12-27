debug printing
printMethodImplementorsOf: anOop
	"Scan the heap printing the oops of any and all methods that implement anOop"
	<api>
	| obj |
	obj := self firstAccessibleObject.
	[obj = nil] whileFalse:
		[((self isCompiledMethod: obj)
		  and: [(self maybeSelectorOfMethod: obj) = anOop]) ifTrue:
			[self printHex: obj; space; printOopShort: obj; cr]]