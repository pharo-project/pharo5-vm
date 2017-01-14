system primitives
primitiveTimezoneOffset
	"return the number of minutes this VM's time value is offset from UTC"

	self primitive:'primitiveTimezoneOffset'.
	^self sqLocGetTimezoneOffset asSmallIntegerObj
