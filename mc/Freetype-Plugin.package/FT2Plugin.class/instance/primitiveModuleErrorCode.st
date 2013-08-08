primitives-error code
primitiveModuleErrorCode
	"high byte is module error, low is generic error"
	self primitive: 'primitiveModuleErrorCode' parameters: #().
	^ (self cCode: 'FT_ERROR_MODULE(errorCode)') asOop: Unsigned