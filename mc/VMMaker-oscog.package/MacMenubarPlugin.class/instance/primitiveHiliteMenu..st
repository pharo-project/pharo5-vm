system primitives
primitiveHiliteMenu: menuID 
	self primitive: 'primitiveHiliteMenu'
		parameters: #(SmallInteger).
	self var: 'menuID' type: 'MenuID'.
	self cCode: 'HiliteMenu(menuID)' inSmalltalk:[].
	^nil