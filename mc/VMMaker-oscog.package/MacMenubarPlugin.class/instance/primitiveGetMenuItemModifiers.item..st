system primitives
primitiveGetMenuItemModifiers: menuHandleOop item: anInteger 
	| menuHandle outModifers |
	self primitive: 'primitiveGetMenuItemModifiers'
		parameters: #(Oop SmallInteger ).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'outModifers' type: 'Style'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	outModifers := 0.
	self cCode: 'GetMenuItemModifiers(menuHandle,anInteger,&outModifers)' inSmalltalk:[menuHandle].
	^outModifers asSmallIntegerObj
	

