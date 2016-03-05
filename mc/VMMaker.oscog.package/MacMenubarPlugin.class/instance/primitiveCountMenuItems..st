system primitives
primitiveCountMenuItems: menuHandleOop 
	| menuHandle returnValue |
	self primitive: 'primitiveCountMenuItems'
		parameters: #(Oop).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	returnValue := self cCode: 'CountMenuItems(menuHandle)' inSmalltalk:[0].
	^returnValue asSmallIntegerObj
