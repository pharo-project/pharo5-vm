system primitives
primitiveCreateStandardWindowMenu: inOptions 
	<var: #menuHandle type: #MenuHandle>
	| menuHandle result |
	self primitive: 'primitiveCreateStandardWindowMenu'
		parameters: #(SmallInteger).
	self cppIf: #'TARGET_API_MAC_CARBON'
		ifTrue: [result := self cCode: 'CreateStandardWindowMenu(inOptions,&menuHandle);' inSmalltalk:[0]].
	^interpreterProxy positiveMachineIntegerFor: (self cCoerce: menuHandle to: #'usqIntptr_t')