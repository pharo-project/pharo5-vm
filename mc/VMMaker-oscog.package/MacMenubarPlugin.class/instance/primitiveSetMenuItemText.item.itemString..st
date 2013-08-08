system primitives
primitiveSetMenuItemText: menuHandleOop item: anInteger itemString: str255
	| menuHandle constStr255 |
	self primitive: 'primitiveSetMenuItemText'
		parameters: #(Oop SmallInteger ByteArray).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'constStr255' type: 'ConstStr255Param'.
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	constStr255 := self cCoerce: str255 to: 'ConstStr255Param'.	
	self cCode: 'SetMenuItemText(menuHandle,anInteger,constStr255)' inSmalltalk:[menuHandle].
	^nil
	