system primitives
primitiveCloseHostWindow: windowIndex
"Close a host window. windowIndex is the SmallInt handle returned previously by primitiveCreateHostWindow. Fail if the index is invalid or the platform code fails"
	| ok |
	self primitive: 'primitiveCloseHostWindow'
		parameters: #(SmallInteger).
	
	ok := self closeWindow: windowIndex.
	ok ifFalse:[interpreterProxy primitiveFail].
