system primitives
primitiveGetMenuItemModifiers: menuHandleOop item: anInteger 
	<var: #menuHandle type: #MenuHandle>
	<var: #outModifers type: #Style>
	| menuHandle outModifers |
	self primitive: 'primitiveGetMenuItemModifiers'
		parameters: #(Oop SmallInteger ).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	outModifers := 0.
	self cCode: 'GetMenuItemModifiers(menuHandle,anInteger,&outModifers)' inSmalltalk:[menuHandle].
	^outModifers asSmallIntegerObj
	

