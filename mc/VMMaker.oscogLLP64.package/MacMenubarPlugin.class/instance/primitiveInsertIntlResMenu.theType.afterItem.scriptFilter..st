system primitives
primitiveInsertIntlResMenu: menuHandleOop theType: aResType afterItem: afterItemInteger scriptFilter:  scriptFilterInteger
	<var: #menuHandle type: #MenuHandle>
	<var: #resType type: #ResType>
	| menuHandle resType |
	self primitive: 'primitiveInsertIntlResMenu'
		parameters: #(Oop SmallInteger SmallInteger SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	resType := self cCoerce: (interpreterProxy positive32BitValueOf: aResType) to: #ResType.
	self cCode: 'InsertIntlResMenu(menuHandle,resType,afterItemInteger,scriptFilterInteger)' inSmalltalk:[menuHandle].
	^nil
	