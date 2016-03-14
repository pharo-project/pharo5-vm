system primitives
primitiveSetMenuItemTextEncoding: menuHandleOop item: anInteger inScriptID: aTextEncodingOop
	<var: #menuHandle type: #MenuHandle>
	<var: #inScriptID type: #TextEncoding>
	| menuHandle inScriptID |
	self primitive: 'primitiveSetMenuItemTextEncoding'
		parameters: #(Oop SmallInteger Oop).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	inScriptID := self cCoerce: (interpreterProxy positive32BitValueOf: aTextEncodingOop) to: #TextEncoding.
	self cCode: 'SetMenuItemTextEncoding(menuHandle,anInteger,inScriptID)' inSmalltalk:[menuHandle].
	^nil