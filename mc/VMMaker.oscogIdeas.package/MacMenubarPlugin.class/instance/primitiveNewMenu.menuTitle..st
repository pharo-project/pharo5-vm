system primitives
primitiveNewMenu: menuID menuTitle: menuTitle
	<var: #menuHandle type: #MenuHandle>
	<var: #constStr255 type: #ConstStr255Param>
	<var: #menuID type: #MenuID>
	| menuHandle constStr255 |
	self primitive: 'primitiveNewMenu'
		parameters: #(SmallInteger ByteArray).
	constStr255 := self cCoerce: menuTitle to: #ConstStr255Param.	
	menuHandle := self cCode: 'NewMenu(menuID,constStr255)' inSmalltalk:[0].
	^interpreterProxy positiveMachineIntegerFor: (self cCoerce: menuHandle to: #'usqIntptr_t')