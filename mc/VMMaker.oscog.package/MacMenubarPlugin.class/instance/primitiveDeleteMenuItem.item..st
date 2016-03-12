system primitives
primitiveDeleteMenuItem: menuHandleOop item: anInteger
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveDeleteMenuItem'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'DeleteMenuItem(menuHandle,anInteger)' inSmalltalk:[menuHandle].
	^nil
