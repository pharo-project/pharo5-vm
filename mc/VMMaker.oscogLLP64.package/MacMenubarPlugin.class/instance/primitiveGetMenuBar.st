system primitives
primitiveGetMenuBar 
	<var: #menuHandle type: #Handle>
	| menuHandle |
	self primitive: 'primitiveGetMenuBar'
		parameters: #().
	menuHandle := self cCode: 'GetMenuBar()' inSmalltalk:[0].
	^interpreterProxy positiveMachineIntegerFor: (self cCoerce: menuHandle to: #'usqIntptr_t')