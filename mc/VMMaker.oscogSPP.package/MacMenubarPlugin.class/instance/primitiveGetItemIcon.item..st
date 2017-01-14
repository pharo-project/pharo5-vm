system primitives
primitiveGetItemIcon: menuHandleOop item: anInteger
	<var: #menuHandle type: #MenuHandle>
	<var: #iconIndex type: #short>
	| menuHandle iconIndex |
	self primitive: 'primitiveGetItemIcon'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	iconIndex := 0.
	self cCode: 'GetItemIcon(menuHandle,anInteger,&iconIndex)' inSmalltalk:[menuHandle].
	^iconIndex asSmallIntegerObj
