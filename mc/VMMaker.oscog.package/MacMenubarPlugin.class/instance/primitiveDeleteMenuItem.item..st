system primitives
primitiveDeleteMenuItem: menuHandleOop item: anInteger
	| menuHandle |
	self primitive: 'primitiveDeleteMenuItem'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'DeleteMenuItem(menuHandle,anInteger)' inSmalltalk:[menuHandle].
	^nil
