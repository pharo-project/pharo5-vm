system primitives
primitiveInsertFontResMenu: menuHandleOop afterItem: afterItemInteger scriptFilter:  scriptFilterInteger
	| menuHandle |
	self primitive: 'primitiveInsertFontResMenu'
		parameters: #(Oop SmallInteger SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'InsertFontResMenu(menuHandle,afterItemInteger,scriptFilterInteger)' inSmalltalk:[menuHandle].
	^nil
	