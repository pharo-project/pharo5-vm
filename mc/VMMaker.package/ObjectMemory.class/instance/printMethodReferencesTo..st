debug printing
printMethodReferencesTo: anOop
	"Scan the heap printing the oops of any and all objects that refer to anOop"
	| oop i |
	<api>
	oop := self firstAccessibleObject.
	[oop = nil] whileFalse:
		[(self isCompiledMethod: oop) ifTrue:
			[i := (self literalCountOf: oop) + LiteralStart - 1.
			 [i >= 0] whileTrue:
				[anOop = (self fetchPointer: i ofObject: oop) ifTrue:
					[self printHex: oop; print: ' @ '; printNum: i; cr.
					 i := 0].
				 i := i - 1]].
		 oop := self accessibleObjectAfter: oop]