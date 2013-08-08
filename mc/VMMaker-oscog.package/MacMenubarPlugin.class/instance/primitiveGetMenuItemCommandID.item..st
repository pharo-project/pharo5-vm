system primitives
primitiveGetMenuItemCommandID: menuHandleOop item: anInteger 
	| menuHandle outCommandID |
	self primitive: 'primitiveGetMenuItemCommandID'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'outCommandID' type: 'MenuCommand'.
	outCommandID := 0.
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'GetMenuItemCommandID(menuHandle,anInteger,&outCommandID)' inSmalltalk:[menuHandle].
	^interpreterProxy positive32BitIntegerFor: outCommandID
	