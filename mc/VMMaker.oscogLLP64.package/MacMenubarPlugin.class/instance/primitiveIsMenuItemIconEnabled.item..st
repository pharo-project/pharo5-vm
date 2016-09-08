system primitives
primitiveIsMenuItemIconEnabled: menuHandleOop item: anInteger
	<var: #menuHandle type: #MenuHandle>
	| menuHandle result |
	self primitive: 'primitiveIsMenuItemIconEnabled'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	result := self cCode: 'IsMenuItemIconEnabled(menuHandle,anInteger)' inSmalltalk:[0].
	^result asOop: Boolean