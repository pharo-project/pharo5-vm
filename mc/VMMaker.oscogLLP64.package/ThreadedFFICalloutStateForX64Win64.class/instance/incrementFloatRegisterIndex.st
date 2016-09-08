accessing
incrementFloatRegisterIndex
	"There are only 4 args passed by register int or float.
	So we can't distinguish the float index from the integer index.
	So we have to increment both.
	
	Consequently, floatRegisterIndex cannot be used anymore to detect presence of float parameter.
	However, we set a signature bitmap indicating which register position is used to pass a float.
	
	IMPLEMENTATION NOTES:
	There are code generator hacks that bypass the accessors.
	So we cannot just redefine the method floatRegisterIndex as ^integerRegisterIndex.
	Instead we must maintain the two indices"

	floatRegisterSignature := floatRegisterSignature + (1 << floatRegisterIndex).
	^integerRegisterIndex := floatRegisterIndex := floatRegisterIndex + 1