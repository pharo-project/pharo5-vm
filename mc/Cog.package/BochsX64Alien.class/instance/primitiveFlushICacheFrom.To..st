primitives
primitiveFlushICacheFrom: startAddress "<Integer>" To: endAddress "<Integer>"
	"Flush the icache in the requested range"
	<primitive: 'primitiveFlushICacheFromTo' module: 'BochsX64Plugin'>
	^self primitiveFailed