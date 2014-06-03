system primitives
primitiveDeleteMenu: menuID 
	self primitive: 'primitiveDeleteMenu'
		parameters: #(SmallInteger).
	
	self var: 'menuID' type: 'MenuID'.
	self cCode: 'DeleteMenu(menuID)' inSmalltalk:[].
	^nil