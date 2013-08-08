simulation only
penultimateLiteralOf: aMethodOop
	self assert: (objectMemory isOopCompiledMethod: aMethodOop).
	^self literal: (self literalCountOf: aMethodOop) - 2 ofMethod: aMethodOop