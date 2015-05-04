inline cacheing
flushICacheFrom: startAddress "<Integer>" to: endAddress "<Integer>"
	<cmacro: '(me,startAddress,endAddress) __clear_cache((char*) startAddress, (char*) (endAddress + 4))'>
	"On ARM we almost certainly need to flush and wash hands. On linux we use __clear_cache (see http://community.arm.com/groups/processors/blog/2010/02/17/caches-and-self-modifying-code for a decent example) and remember that the end address is *exclusive* so we add 4 for now"
	self halt: #ceFlushICache