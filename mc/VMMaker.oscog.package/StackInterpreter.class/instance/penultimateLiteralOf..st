debug printing
penultimateLiteralOf: aMethodOop
	<api>
	self assert: (objectMemory isOopCompiledMethod: aMethodOop).
	^self literal: (self literalCountOf: aMethodOop) - 2 ofMethod: aMethodOop