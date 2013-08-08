system primitives
primitiveGetMenuItemHierarchicalID: menuHandleOop item: anInteger 
	| menuHandle outHierID |
	self primitive: 'primitiveGetMenuItemHierarchicalID'
		parameters: #(Oop SmallInteger ).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'outHierID' type: 'MenuID'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	outHierID := 0.
	self cCode: 'GetMenuItemHierarchicalID(menuHandle,anInteger,&outHierID)' inSmalltalk:[menuHandle].
	^outHierID asSmallIntegerObj

