system primitives
primitiveSetMenuItemModifiers: menuHandleOop item: anInteger inModifiers: aUInt8
	| menuHandle |
	self primitive: 'primitiveSetMenuItemModifiers'
		parameters: #(Oop SmallInteger SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.

	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetMenuItemModifiers(menuHandle,anInteger,aUInt8)' inSmalltalk:[menuHandle].
	^nil