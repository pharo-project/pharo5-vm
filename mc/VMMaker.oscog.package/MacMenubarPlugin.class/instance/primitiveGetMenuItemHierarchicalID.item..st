system primitives
primitiveGetMenuItemHierarchicalID: menuHandleOop item: anInteger 
	<var: #menuHandle type: #MenuHandle>
	<var: #outHierID type: #MenuID>
	| menuHandle outHierID |
	self primitive: 'primitiveGetMenuItemHierarchicalID'
		parameters: #(Oop SmallInteger ).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	outHierID := 0.
	self cCode: 'GetMenuItemHierarchicalID(menuHandle,anInteger,&outHierID)' inSmalltalk:[menuHandle].
	^outHierID asSmallIntegerObj

