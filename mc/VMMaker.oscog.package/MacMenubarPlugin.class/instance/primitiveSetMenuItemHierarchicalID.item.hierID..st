system primitives
primitiveSetMenuItemHierarchicalID: menuHandleOop item: anInteger hierID: aMenuID
	<var: #menuHandle type: #MenuHandle>
	<var: #aMenuID type: #MenuID>
	| menuHandle |
	self primitive: 'primitiveSetMenuItemHierarchicalID'
		parameters: #(Oop SmallInteger SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetMenuItemHierarchicalID(menuHandle,anInteger,aMenuID)' inSmalltalk:[menuHandle].
	^nil