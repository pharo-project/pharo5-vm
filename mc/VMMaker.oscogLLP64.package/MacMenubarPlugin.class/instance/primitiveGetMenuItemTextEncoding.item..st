system primitives
primitiveGetMenuItemTextEncoding: menuHandleOop item: anInteger
	<var: #menuHandle type: #MenuHandle>
	<var: #outScriptID type: #TextEncoding>
	| menuHandle outScriptID |
	self primitive: 'primitiveGetMenuItemTextEncoding'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'GetMenuItemTextEncoding(menuHandle,anInteger,&outScriptID)' inSmalltalk:[menuHandle].
	^interpreterProxy positive32BitIntegerFor: outScriptID