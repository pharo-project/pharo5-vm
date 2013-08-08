system primitives
primitiveEnableMenuItem: menuHandleOop item: anInteger
	| menuHandle |
	self primitive: 'primitiveEnableMenuItem'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'EnableMenuItem(menuHandle,anInteger)' inSmalltalk:[menuHandle].
	^nil
