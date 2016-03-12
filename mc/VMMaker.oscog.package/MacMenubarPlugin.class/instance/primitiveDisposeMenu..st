system primitives
primitiveDisposeMenu: menuHandleOop 
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveDisposeMenu'
		parameters: #(Oop).	
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'DisposeMenu(menuHandle)' inSmalltalk:[menuHandle].
	^nil
