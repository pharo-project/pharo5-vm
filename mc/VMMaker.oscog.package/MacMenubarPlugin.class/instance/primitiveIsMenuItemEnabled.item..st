system primitives
primitiveIsMenuItemEnabled: menuHandleOop item: anInteger
	<var: #menuHandle type: #MenuHandle>
	| menuHandle result |
	self primitive: 'primitiveIsMenuItemEnabled'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	result := self cCode: 'IsMenuItemEnabled(menuHandle,anInteger)' inSmalltalk:[0].
	^result asOop: Boolean