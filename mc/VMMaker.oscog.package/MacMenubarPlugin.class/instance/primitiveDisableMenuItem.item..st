system primitives
primitiveDisableMenuItem: menuHandleOop item: anInteger
	| menuHandle |
	self primitive: 'primitiveDisableMenuItem'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'DisableMenuItem(menuHandle,anInteger)' inSmalltalk:[menuHandle].
	^nil
