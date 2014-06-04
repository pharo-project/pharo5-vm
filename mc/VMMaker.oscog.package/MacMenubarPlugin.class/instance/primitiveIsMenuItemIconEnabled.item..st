system primitives
primitiveIsMenuItemIconEnabled: menuHandleOop item: anInteger

	| menuHandle result |
	self primitive: 'primitiveIsMenuItemIconEnabled'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	result := self cCode: 'IsMenuItemIconEnabled(menuHandle,anInteger)' inSmalltalk:[0].
	^result asOop: Boolean