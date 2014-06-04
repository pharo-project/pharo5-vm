system primitives
primitiveInsertMenu: menuHandleOop beforeID: anInteger
	| menuHandle |
	self primitive: 'primitiveInsertMenu'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'anInteger' type: 'MenuID'.

	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'InsertMenu(menuHandle,anInteger)' inSmalltalk:[menuHandle].
	^nil