system primitives
primitiveCountMenuItems: menuHandleOop 
	<var: #menuHandle type: #MenuHandle>
	| menuHandle returnValue |
	self primitive: 'primitiveCountMenuItems'
		parameters: #(Oop).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	returnValue := self cCode: 'CountMenuItems(menuHandle)' inSmalltalk:[0].
	^returnValue asSmallIntegerObj
