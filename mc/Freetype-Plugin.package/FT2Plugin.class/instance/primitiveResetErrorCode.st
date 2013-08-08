primitives-error code
primitiveResetErrorCode
	| oldError |
	self primitive: 'primitiveResetErrorCode' parameters: #().
	oldError := errorCode.
	errorCode := 0.
	^ oldError asOop: Unsigned