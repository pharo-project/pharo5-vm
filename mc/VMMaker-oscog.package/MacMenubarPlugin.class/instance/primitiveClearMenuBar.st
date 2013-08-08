system primitives
primitiveClearMenuBar 
	self primitive: 'primitiveClearMenuBar'
		parameters: #().
	
	self cCode: 'ClearMenuBar()' inSmalltalk:[].
	^nil