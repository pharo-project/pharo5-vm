system primitives
primitiveSetMenuItemHierarchicalID: menuHandleOop item: anInteger hierID: aMenuID
	| menuHandle |
	self primitive: 'primitiveSetMenuItemHierarchicalID'
		parameters: #(Oop SmallInteger SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'menuID' type: 'MenuID'.

	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetMenuItemHierarchicalID(menuHandle,anInteger,aMenuID)' inSmalltalk:[menuHandle].
	^nil