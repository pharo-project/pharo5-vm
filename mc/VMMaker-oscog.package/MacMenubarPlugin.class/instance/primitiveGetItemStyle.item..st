system primitives
primitiveGetItemStyle: menuHandleOop item: anInteger 
	| menuHandle chStyle |
	self primitive: 'primitiveGetItemStyle'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'chStyle' type: 'Style'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	chStyle := 0.
	self cCode: 'GetItemStyle(menuHandle,anInteger,&chStyle)' inSmalltalk:[menuHandle].
	^chStyle asSmallIntegerObj

