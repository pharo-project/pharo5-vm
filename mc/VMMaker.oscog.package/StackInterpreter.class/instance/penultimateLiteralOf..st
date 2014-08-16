debug printing
penultimateLiteralOf: aMethodOop
	<api>
	self assert: (objectMemory isOopCompiledMethod: aMethodOop).
	^self literal: (objectMemory literalCountOf: aMethodOop) - 2 ofMethod: aMethodOop