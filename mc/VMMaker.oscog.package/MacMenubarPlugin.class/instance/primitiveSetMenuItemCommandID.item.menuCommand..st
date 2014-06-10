system primitives
primitiveSetMenuItemCommandID: menuHandleOop item: anInteger menuCommand:  inCommandID
	| menuHandle commandID |
	self primitive: 'primitiveSetMenuItemCommandID'
		parameters: #(Oop SmallInteger Oop).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'commandID' type: 'MenuCommand'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	commandID := self cCoerce: (interpreterProxy positive32BitValueOf: inCommandID) to: 'MenuCommand'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetMenuItemCommandID(menuHandle,anInteger,commandID)' inSmalltalk:[menuHandle].
	^nil
	