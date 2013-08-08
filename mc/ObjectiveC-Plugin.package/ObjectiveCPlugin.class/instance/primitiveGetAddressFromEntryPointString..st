system primitives
primitiveGetAddressFromEntryPointString: aEntryPointName
	| entryPointNameLength fn entryPointName  |
	self primitive: 'primitiveGetAddressFromEntryPointString'
		parameters: #(String).

	self var: 'entryPointName' declareC: 'char entryPointName[256]'.
	self var: 'fn' declareC: 'void * fn'.
	entryPointNameLength := interpreterProxy slotSizeOf: aEntryPointName cPtrAsOop.
	entryPointNameLength > 255 ifTrue: [^interpreterProxy positive64BitIntegerFor: 0].
	self str: entryPointName l: aEntryPointName cpy: entryPointNameLength+1.
	fn  := self dl: -2 sym: entryPointName.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: fn to: 'usqInt') 