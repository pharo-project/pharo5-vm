system primitives
primitiveGetMenuHandle: menuID 
	<var: #menuHandle type: #MenuHandle>
	<var: #menuID type: #MenuID>
	| menuHandle |
	self primitive: 'primitiveGetMenuHandle'
		parameters: #(SmallInteger).
	menuHandle := self cCode: 'GetMenuHandle(menuID)' inSmalltalk:[0].
	^interpreterProxy positiveMachineIntegerFor: (self cCoerce: menuHandle to: #'usqIntptr_t')