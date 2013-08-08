system primitives
primitiveInsertMenuItem: menuHandleOop itemString: str255 afterItem: anInteger
	| menuHandle constStr255 |
	self primitive: 'primitiveInsertMenuItem'
		parameters: #(Oop ByteArray SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'constStr255' type: 'ConstStr255Param'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	constStr255 := self cCoerce: str255 to: 'ConstStr255Param'.	
	self cCode: 'InsertMenuItem(menuHandle,constStr255,anInteger)' inSmalltalk:[menuHandle].
	^nil
	