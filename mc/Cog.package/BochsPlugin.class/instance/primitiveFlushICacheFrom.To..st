primitives
"cpuAlien <BochsIA32|X86Alien>" primitiveFlushICacheFrom: startAddress "<Integer>" To: endAddress "<Integer>"
	"Flush the icache in the requested range"
	| cpuAlien cpu |
	<var: #cpu type: #'void *'>
	cpuAlien := self primitive: #primitiveFlushICacheFromTo
					parameters: #(Unsigned Unsigned)
					receiver: #Oop.
	(cpu := self cCoerceSimple: (self startOfData: cpuAlien) to: #'void *') = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	self flushICache: cpu From: startAddress To: endAddress