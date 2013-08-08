system primitives
primitiveDisableMenuCommand: menuHandleOop item: anInteger
	| menuHandle commandID |
	self primitive: 'primitiveDisableMenuCommand'
		parameters: #(Oop Oop).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'commandID' type: 'MenuCommand'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	commandID := self cCoerce: (interpreterProxy positive32BitValueOf: anInteger) to: 'MenuCommand'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: '#if TARGET_API_MAC_CARBON
DisableMenuCommand(menuHandle,commandID);
#endif' inSmalltalk:[menuHandle].
	^nil
