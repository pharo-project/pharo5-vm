inline cacheing
flushICacheFrom: startAddress "<Integer>" to: endAddress "<Integer>"
	<cmacro: '(me,startAddress,endAddress) 0'>
	"On Intel processors where code and data have the same linear address, no
	 special action is required to flush the instruciton cache.  One only needs to
	 execute a serializing instruction (e.g. CPUID) if code and data are at different
	 virtual addresses (e.g. a debugger using memory-mapping to access a debugee).
	 Using the macro avoids an unnecessary call."
	self halt: #ceFlushICache