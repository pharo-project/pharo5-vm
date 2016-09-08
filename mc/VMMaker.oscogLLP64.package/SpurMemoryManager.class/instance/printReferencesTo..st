debug printing
printReferencesTo: anOop
	"Scan the heap printing the oops of any and all objects that refer to anOop"
	<api>
	self allObjectsDo:
		[:obj| | i |
		 i := self numPointerSlotsOf: obj.
		 [(i := i - 1) >= 0] whileTrue:
			[anOop = (self fetchPointer: i ofMaybeForwardedObject: obj) ifTrue:
				[coInterpreter printHex: obj; print: ' @ '; printNum: i; space; printOopShort: obj; cr.
				 i := 0]]]