system primitives
primitiveSetMenuTitle: menuHandleOop  title: str255
	| menuHandle constStr255 |
	self primitive: 'primitiveSetMenuTitle'
		parameters: #(Oop ByteArray).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'constStr255' type: 'ConstStr255Param'.
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	constStr255 := self cCoerce: str255 to: 'ConstStr255Param'.	
	self cCode: 'SetMenuTitle(menuHandle,constStr255)' inSmalltalk:[menuHandle].
	^nil
	