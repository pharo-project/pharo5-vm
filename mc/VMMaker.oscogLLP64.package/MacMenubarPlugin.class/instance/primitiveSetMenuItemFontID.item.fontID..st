system primitives
primitiveSetMenuItemFontID: menuHandleOop item: anInteger fontID: aFontIDInteger  
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveSetMenuItemFontID'
		parameters: #(Oop SmallInteger SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetMenuItemFontID(menuHandle,anInteger,aFontIDInteger)' inSmalltalk:[menuHandle].
	^nil
	