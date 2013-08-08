system primitives
primitiveDisposeMenu: menuHandleOop 
	| menuHandle |
	self primitive: 'primitiveDisposeMenu'
		parameters: #(Oop).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'DisposeMenu(menuHandle)' inSmalltalk:[menuHandle].
	^nil
