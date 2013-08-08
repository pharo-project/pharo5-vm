primitives
"cpuAlien <BochsIA32Alien>" primitiveFlushICacheFrom: startAddress "<Integer>" To: endAddress "<Integer>"
	"Flush the icache in the requested range"
	| cpuAlien cpu |
	<var: #cpu type: 'void *'>
	cpuAlien := self primitive: #primitiveFlushICacheFromTo
					parameters: #(Unsigned Unsigned)
					receiver: #Oop.
	(cpu := self startOfData: cpuAlien) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	self flushICache: cpu From: startAddress To: endAddress