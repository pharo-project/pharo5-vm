system primitives
primitiveGetMenuItemCommandID: menuHandleOop item: anInteger 
	<var: #menuHandle type: #MenuHandle>
	<var: #outCommandID type: #MenuCommand>
	| menuHandle outCommandID |
	self primitive: 'primitiveGetMenuItemCommandID'
		parameters: #(Oop SmallInteger).
	outCommandID := 0.
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'GetMenuItemCommandID(menuHandle,anInteger,&outCommandID)' inSmalltalk:[menuHandle].
	^interpreterProxy positive32BitIntegerFor: outCommandID
	