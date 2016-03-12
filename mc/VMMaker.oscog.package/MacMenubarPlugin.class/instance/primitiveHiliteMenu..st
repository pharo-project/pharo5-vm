system primitives
primitiveHiliteMenu: menuID 
	<var: #menuID type: #MenuID>
	self primitive: 'primitiveHiliteMenu'
		parameters: #(SmallInteger).
	self cCode: 'HiliteMenu(menuID)' inSmalltalk:[].
	^nil