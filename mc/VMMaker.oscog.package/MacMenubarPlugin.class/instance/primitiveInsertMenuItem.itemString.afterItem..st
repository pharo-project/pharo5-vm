system primitives
primitiveInsertMenuItem: menuHandleOop itemString: str255 afterItem: anInteger
	<var: #menuHandle type: #MenuHandle>
	<var: #constStr255 type: #ConstStr255Param>
	| menuHandle constStr255 |
	self primitive: 'primitiveInsertMenuItem'
		parameters: #(Oop ByteArray SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	constStr255 := self cCoerce: str255 to: #ConstStr255Param.
	self cCode: 'InsertMenuItem(menuHandle,constStr255,anInteger)' inSmalltalk:[menuHandle].
	^nil
	