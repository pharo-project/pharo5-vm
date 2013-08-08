tests
testCPUHasSSE2
	"Use the CPUID instruction to check if SSE2 is supported.  Cog
	 uses SSE2 instructions for machine-code floating-point primitives."
	self processor eax: 0. "get vendor identfication string"
	self processor eip: 0; singleStepIn: (ByteArray with: 16r0F with: 16rA2 with: 16r90) "cpuid;nop".
	self assert: self processor eip = 2.
	self assert: self processor eax >= 1.
	self processor eax: 1.
	self processor eip: 0; singleStepIn: (ByteArray with: 16r0F with: 16rA2 with: 16r90) "cpuid;nop".
	self assert: self processor eip = 2.
	self assert: (self processor edx bitAnd: 1 << 26) ~= 0

	"self new testCPUHasSSE2"