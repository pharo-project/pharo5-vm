debug printing
ultimateLiteralOf: aMethodOop
	<api>
	self assert: (objectMemory isOopCompiledMethod: aMethodOop).
	^self literal: (objectMemory literalCountOf: aMethodOop) - 1 ofMethod: aMethodOop