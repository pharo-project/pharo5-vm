system primitives
primitiveEnableMenuItem: menuHandleOop item: anInteger
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveEnableMenuItem'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'EnableMenuItem(menuHandle,anInteger)' inSmalltalk:[menuHandle].
	^nil
