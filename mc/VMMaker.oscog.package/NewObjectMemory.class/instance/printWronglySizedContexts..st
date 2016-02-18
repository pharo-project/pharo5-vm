debug printing
printWronglySizedContexts: printContexts
	"Scan the heap printing the oops of any and all contexts whose size is not either SmallContextSize or LargeContextSize"
	| oop |
	<api>
	oop := self firstAccessibleObject.
	[oop = nil] whileFalse:
		[((self isContextNonImm: oop)
		   and: [self badContextSize: oop]) ifTrue:
			[self printHex: oop; space; printNum: (self numBytesOf: oop); cr.
			 printContexts ifTrue:
				[coInterpreter printContext: oop]].
		 oop := self accessibleObjectAfter: oop]