system primitives
primitiveSetMenuItemCommandID: menuHandleOop item: anInteger menuCommand:  inCommandID
	<var: #menuHandle type: #MenuHandle>
	<var: #commandID type: #MenuCommand>
	| menuHandle commandID |
	self primitive: 'primitiveSetMenuItemCommandID'
		parameters: #(Oop SmallInteger Oop).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	commandID := self cCoerce: (interpreterProxy positive32BitValueOf: inCommandID) to: #MenuCommand.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetMenuItemCommandID(menuHandle,anInteger,commandID)' inSmalltalk:[menuHandle].
	^nil
	