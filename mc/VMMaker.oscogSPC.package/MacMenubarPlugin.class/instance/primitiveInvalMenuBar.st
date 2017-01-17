system primitives
primitiveInvalMenuBar
	self primitive: 'primitiveInvalMenuBar'
		parameters: #().
	
	self cCode: 'InvalMenuBar()' inSmalltalk:[].
	^nil