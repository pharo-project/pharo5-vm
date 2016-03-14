system primitives
primitiveCheckMenuItem: menuHandleOop item: anInteger checked: aBoolean
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveCheckMenuItem'
		parameters: #(Oop SmallInteger Boolean).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'CheckMenuItem(menuHandle,anInteger,aBoolean)' inSmalltalk:[menuHandle].
	^nil

