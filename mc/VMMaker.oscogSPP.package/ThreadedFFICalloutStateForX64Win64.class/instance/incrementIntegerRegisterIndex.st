accessing
incrementIntegerRegisterIndex
	"There are only 4 args passed by register int or float.
	So we can't distinguish the float index from the integer index.
	So we have to increment both.
	
	IMPLEMENTATION NOTES:
	There are code generator hacks that bypass the accessors.
	So we cannot just redefine the method floatRegisterIndex as ^integerRegisterIndex.
	Instead we must maintain the two indices"

	^floatRegisterIndex := integerRegisterIndex := integerRegisterIndex + 1