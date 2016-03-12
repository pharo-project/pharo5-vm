system primitives
primitiveDisableMenuItemIcon: menuHandleOop item: anInteger
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveDisableMenuItemIcon'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'DisableMenuItemIcon(menuHandle,anInteger)' inSmalltalk:[menuHandle].
	^nil
