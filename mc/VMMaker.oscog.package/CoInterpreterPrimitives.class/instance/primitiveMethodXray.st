indexing primitives
primitiveMethodXray
	"Lift the veil from a method and answer an integer describing the interior state
	 of its machine code.
	 Used for e.g. VM tests so they can verify they're testing what they think they're testing.
	 0 implies a vanilla method.
	 Bit 0 = method is currently compiled to machine code
	 Bit 1 = is compiled frameless.
	 Bit 2 = method refers to young object"
	<export: true>
	| flags cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	(self maybeMethodHasCogMethod: self stackTop)
		ifTrue:
			[cogMethod := self cogMethodOf: self stackTop.
			 flags := cogMethod stackCheckOffset = 0 ifTrue: [3] ifFalse: [1].
			 cogMethod cmRefersToYoung ifTrue:
				[flags := flags + 4]]
		ifFalse: [flags := 0].
	self pop: 1 thenPush: (objectMemory integerObjectOf: flags)