system primitives
primitiveCallbackLeave: aNumber

	self primitive: 'primitiveCallbackLeave'
		parameters: #(SmallInteger).
	aNumber = 0 ifTrue: [^self].
	interpreterProxy callbackLeave: aNumber.