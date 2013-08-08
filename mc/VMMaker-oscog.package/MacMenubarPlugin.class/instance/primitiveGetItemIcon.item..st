system primitives
primitiveGetItemIcon: menuHandleOop item: anInteger
	| menuHandle iconIndex |
	self primitive: 'primitiveGetItemIcon'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'iconIndex' type: 'short'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	iconIndex := 0.
	self cCode: 'GetItemIcon(menuHandle,anInteger,&iconIndex)' inSmalltalk:[menuHandle].
	^iconIndex asSmallIntegerObj
