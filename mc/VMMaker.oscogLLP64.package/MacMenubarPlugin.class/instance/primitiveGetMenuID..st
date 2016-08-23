system primitives
primitiveGetMenuID: menuHandleOop 
	<var: #menuHandle type: #MenuHandle>
	<var: #menuID type: #MenuID>
	| menuHandle menuID |
	self primitive: 'primitiveGetMenuID'
		parameters: #(Oop ).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'menuID = GetMenuID(menuHandle)' inSmalltalk:[menuHandle].
	^menuID asSmallIntegerObj
	