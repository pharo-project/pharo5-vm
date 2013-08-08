system primitives
primitiveEnableMenuItemIcon: menuHandleOop item: anInteger
	| menuHandle |
	self primitive: 'primitiveEnableMenuItemIcon'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'EnableMenuItemIcon(menuHandle,anInteger)' inSmalltalk:[menuHandle].
	^nil
