system primitives
primitiveDisableMenuItemIcon: menuHandleOop item: anInteger
	| menuHandle |
	self primitive: 'primitiveDisableMenuItemIcon'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'DisableMenuItemIcon(menuHandle,anInteger)' inSmalltalk:[menuHandle].
	^nil
