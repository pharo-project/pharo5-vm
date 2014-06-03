system primitives
primitiveSetMenuItemTextEncoding: menuHandleOop item: anInteger inScriptID: aTextEncodingOop
	| menuHandle inScriptID |
	self primitive: 'primitiveSetMenuItemTextEncoding'
		parameters: #(Oop SmallInteger Oop).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'inScriptID' type: 'TextEncoding'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	inScriptID := self cCoerce: (interpreterProxy positive32BitValueOf: aTextEncodingOop) to: 'TextEncoding'.
	self cCode: 'SetMenuItemTextEncoding(menuHandle,anInteger,inScriptID)' inSmalltalk:[menuHandle].
	^nil