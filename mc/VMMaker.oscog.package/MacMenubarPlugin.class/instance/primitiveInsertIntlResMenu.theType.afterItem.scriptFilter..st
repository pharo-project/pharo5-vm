system primitives
primitiveInsertIntlResMenu: menuHandleOop theType: aResType afterItem: afterItemInteger scriptFilter:  scriptFilterInteger
	| menuHandle resType |
	self primitive: 'primitiveInsertIntlResMenu'
		parameters: #(Oop SmallInteger SmallInteger SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'resType' type: 'ResType'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	resType := self cCoerce: (interpreterProxy positive32BitValueOf: aResType) to: 'ResType'.
	self cCode: 'InsertIntlResMenu(menuHandle,resType,afterItemInteger,scriptFilterInteger)' inSmalltalk:[menuHandle].
	^nil
	