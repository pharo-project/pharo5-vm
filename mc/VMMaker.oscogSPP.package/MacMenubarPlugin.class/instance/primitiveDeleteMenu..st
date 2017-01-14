system primitives
primitiveDeleteMenu: menuID 
	<var: #menuID type: #MenuID>
	self primitive: 'primitiveDeleteMenu'
		parameters: #(SmallInteger).
	self cCode: 'DeleteMenu(menuID)' inSmalltalk:[].
	^nil