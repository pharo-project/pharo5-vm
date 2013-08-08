primitives-error code
primitiveErrorCode
	"high byte is module error, low is generic error"
	self primitive: 'primitiveErrorCode' parameters: #().
	^ (self cCode: 'FT_ERROR_BASE(errorCode)') asOop: Unsigned