system primitives
primitiveSetMenuItemModifiers: menuHandleOop item: anInteger inModifiers: aUInt8
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveSetMenuItemModifiers'
		parameters: #(Oop SmallInteger SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetMenuItemModifiers(menuHandle,anInteger,aUInt8)' inSmalltalk:[menuHandle].
	^nil