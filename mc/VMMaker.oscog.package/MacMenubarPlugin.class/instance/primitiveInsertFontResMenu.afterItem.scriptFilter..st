system primitives
primitiveInsertFontResMenu: menuHandleOop afterItem: afterItemInteger scriptFilter:  scriptFilterInteger
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveInsertFontResMenu'
		parameters: #(Oop SmallInteger SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'InsertFontResMenu(menuHandle,afterItemInteger,scriptFilterInteger)' inSmalltalk:[menuHandle].
	^nil
	