system primitives
primitiveGetMenuBar 
	| menuHandle |
	self primitive: 'primitiveGetMenuBar'
		parameters: #().
	self var: 'menuHandle' type: 'Handle'.
	menuHandle := self cCode: 'GetMenuBar()' inSmalltalk:[0].
	^interpreterProxy positiveMachineIntegerFor: (self cCoerce: menuHandle to: 'long')