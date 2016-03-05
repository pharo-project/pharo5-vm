system primitives
primitiveGetIndMenuWithCommandID: menuHandleOop commandID: aCommandID
	| menuHandle commandID applicationMenu outIndex |
	self primitive: 'primitiveGetIndMenuWithCommandID'
		parameters: #(Oop Oop).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'commandID' type: 'MenuCommand'.
	self var: 'applicationMenu' type: 'MenuHandle'.
	self var: 'outIndex' type: 'MenuItemIndex'.

	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: 'MenuHandle'.
	commandID := self cCoerce: (interpreterProxy positive32BitValueOf: aCommandID) to: 'MenuCommand'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: '#if TARGET_API_MAC_CARBON
GetIndMenuItemWithCommandID(menuHandle, kHICommandHide, 1,
                   &applicationMenu, &outIndex);
#endif ' inSmalltalk:[menuHandle].
	outIndex asSmallIntegerObj. "to avoid elimination of the variable..."
	^interpreterProxy positiveMachineIntegerFor: (self cCoerce: applicationMenu to: 'long')

