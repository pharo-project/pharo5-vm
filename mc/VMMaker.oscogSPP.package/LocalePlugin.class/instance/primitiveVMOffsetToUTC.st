system primitives
primitiveVMOffsetToUTC
	"return the number of minutes this VM's time value is offset from UTC"

	self primitive:'primitiveVMOffsetToUTC'.
	^self sqLocGetVMOffsetToUTC asSmallIntegerObj
