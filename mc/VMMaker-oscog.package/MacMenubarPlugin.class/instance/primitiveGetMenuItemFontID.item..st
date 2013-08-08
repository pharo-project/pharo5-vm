system primitives
primitiveGetMenuItemFontID: menuHandleOop item: anInteger 
	| menuHandle outFontID |
	self primitive: 'primitiveGetMenuItemFontID'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'outFontID' type: 'SInt16'.
	outFontID := 0.
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'GetMenuItemFontID(menuHandle,anInteger,&outFontID)' inSmalltalk:[menuHandle].
	^outFontID asSmallIntegerObj
	