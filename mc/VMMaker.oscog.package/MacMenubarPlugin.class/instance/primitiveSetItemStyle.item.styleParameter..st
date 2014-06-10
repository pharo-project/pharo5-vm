system primitives
primitiveSetItemStyle: menuHandleOop item: anInteger styleParameter: chStyleInteger
	| menuHandle |
	self primitive: 'primitiveSetItemStyle'
		parameters: #(Oop SmallInteger SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetItemStyle(menuHandle,anInteger,chStyleInteger)' inSmalltalk:[menuHandle].
	^nil

