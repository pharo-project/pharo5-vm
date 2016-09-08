system primitives
primitiveGetMenuItemFontID: menuHandleOop item: anInteger 
	<var: #menuHandle type: #MenuHandle>
	<var: #outFontID type: #SInt16>
	| menuHandle outFontID |
	self primitive: 'primitiveGetMenuItemFontID'
		parameters: #(Oop SmallInteger).
	outFontID := 0.
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'GetMenuItemFontID(menuHandle,anInteger,&outFontID)' inSmalltalk:[menuHandle].
	^outFontID asSmallIntegerObj
	