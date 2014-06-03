system primitives
primitiveShowMenuBar 
	self primitive: 'primitiveShowMenuBar'
		parameters: #().
	
	self cCode: 'ShowMenuBar()' inSmalltalk:[].
	^nil