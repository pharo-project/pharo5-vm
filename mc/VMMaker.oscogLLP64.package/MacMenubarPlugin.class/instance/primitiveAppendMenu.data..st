system primitives
primitiveAppendMenu: menuHandleOop data: str255
	<var: #menuHandle type: #MenuHandle>
	<var: #constStr255 type: #ConstStr255Param>
	| menuHandle constStr255 |
	self primitive: 'primitiveAppendMenu'
		parameters: #(Oop ByteArray).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	constStr255 := self cCoerce: str255 to: #ConstStr255Param.	
	self cCode: 'AppendMenu(menuHandle,constStr255)' inSmalltalk:[menuHandle].
	^nil