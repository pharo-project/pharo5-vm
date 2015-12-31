inline cacheing
flushICacheFrom: startAddress "<Integer>" to: endAddress "<Integer>"
	<cmacro: '(me,startAddress,endAddress) cacheflush((char*) startAddress, endAddress - startAddress, ICACHE)'>
	"See http://www.linux-mips.org/wiki/Cacheflush_Syscall"
	self halt: #ceFlushICache