system primitives
primitiveSetMenuItemFontID: menuHandleOop item: anInteger fontID: aFontIDInteger  
	| menuHandle |
	self primitive: 'primitiveSetMenuItemFontID'
		parameters: #(Oop SmallInteger SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetMenuItemFontID(menuHandle,anInteger,aFontIDInteger)' inSmalltalk:[menuHandle].
	^nil
	