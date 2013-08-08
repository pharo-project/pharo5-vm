system primitives
primitiveGetMenuItemTextEncoding: menuHandleOop item: anInteger
	| menuHandle outScriptID |
	self primitive: 'primitiveGetMenuItemTextEncoding'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'outScriptID' type: 'TextEncoding'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'GetMenuItemTextEncoding(menuHandle,anInteger,&outScriptID)' inSmalltalk:[menuHandle].
	^interpreterProxy positive32BitIntegerFor: outScriptID