system primitives
primitiveDrawMenuBar
	self primitive: 'primitiveDrawMenuBar'
		parameters: #().
	
	self cCode: 'DrawMenuBar()' inSmalltalk:[].
	^nil