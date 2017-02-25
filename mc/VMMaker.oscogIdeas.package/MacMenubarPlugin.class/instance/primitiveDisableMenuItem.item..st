system primitives
primitiveDisableMenuItem: menuHandleOop item: anInteger
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveDisableMenuItem'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'DisableMenuItem(menuHandle,anInteger)' inSmalltalk:[menuHandle].
	^nil
