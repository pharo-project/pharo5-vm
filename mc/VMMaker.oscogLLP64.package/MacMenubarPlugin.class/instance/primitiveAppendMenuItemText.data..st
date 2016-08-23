system primitives
primitiveAppendMenuItemText: menuHandleOop data: str255
	<var: #menuHandle type: #MenuHandle>
	<var: #constStr255 type: #ConstStr255Param>
	| menuHandle constStr255 |
	self primitive: 'primitiveAppendMenuItemText'
		parameters: #(Oop ByteArray).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	constStr255 := self cCoerce: str255 to: #ConstStr255Param.	
	self cCode: 'AppendMenuItemText(menuHandle,constStr255)' inSmalltalk:[menuHandle].
	^nil