system primitives
primitiveHideMenuBar 
	self primitive: 'primitiveHideMenuBar'
		parameters: #().
	
	self cCode: 'HideMenuBar()' inSmalltalk:[].
	^nil