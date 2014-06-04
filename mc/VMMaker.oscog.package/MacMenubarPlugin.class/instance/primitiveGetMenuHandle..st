system primitives
primitiveGetMenuHandle: menuID 
	| menuHandle |
	self primitive: 'primitiveGetMenuHandle'
		parameters: #(SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'menuID' type: 'MenuID'.
	menuHandle := self cCode: 'GetMenuHandle(menuID)' inSmalltalk:[0].
	^interpreterProxy positive32BitIntegerFor: (self cCoerce: menuHandle to: 'long')