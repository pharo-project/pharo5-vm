system primitives
primitiveCreateStandardWindowMenu: inOptions 

	| menuHandle result |
	self primitive: 'primitiveCreateStandardWindowMenu'
		parameters: #(SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	self cCode: '#if TARGET_API_MAC_CARBON
'.
	result := self cCode: 'CreateStandardWindowMenu(inOptions,&menuHandle);
#endif' inSmalltalk:[0].
	^interpreterProxy positive32BitIntegerFor: (self cCoerce: menuHandle to: 'long')