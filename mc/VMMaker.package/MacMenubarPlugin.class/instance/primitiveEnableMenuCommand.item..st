system primitives
primitiveEnableMenuCommand: menuHandleOop item: anInteger
	| menuHandle commandID |
	self primitive: 'primitiveEnableMenuCommand'
		parameters: #(Oop Oop).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'commandID' type: 'MenuCommand'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	commandID := self cCoerce: (interpreterProxy positive32BitValueOf: anInteger) to: 'MenuCommand'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: '#if TARGET_API_MAC_CARBON
EnableMenuCommand(menuHandle,commandID);
#endif' inSmalltalk:[menuHandle].
	^nil