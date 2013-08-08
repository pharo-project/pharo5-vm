system primitives
primitiveGetMenuID: menuHandleOop 
	| menuHandle menuID |
	
	self primitive: 'primitiveGetMenuID'
		parameters: #(Oop ).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'menuID' type: 'MenuID'.
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'menuID = GetMenuID(menuHandle)' inSmalltalk:[menuHandle].
	^menuID asSmallIntegerObj
	