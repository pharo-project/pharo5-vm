system primitives
primitiveNewMenu: menuID menuTitle: menuTitle

	| menuHandle constStr255 |
	self primitive: 'primitiveNewMenu'
		parameters: #(SmallInteger ByteArray).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'constStr255' type: 'ConstStr255Param'.
	self var: 'menuID' type: 'MenuID'.
	
	constStr255 := self cCoerce: menuTitle to: 'ConstStr255Param'.	
	menuHandle := self cCode: 'NewMenu(menuID,constStr255)' inSmalltalk:[0].
	^interpreterProxy positive32BitIntegerFor: (self cCoerce: menuHandle to: 'long')