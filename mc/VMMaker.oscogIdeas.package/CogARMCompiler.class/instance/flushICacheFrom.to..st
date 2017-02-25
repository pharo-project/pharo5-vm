inline cacheing
flushICacheFrom: startAddress "<Integer>" to: endAddress "<Integer>"
	<cmacro: '(me,startAddress,endAddress) __clear_cache((char*) startAddress, (char*) (endAddress ))'>
	"On ARM we almost certainly need to flush and wash hands. On linux we use __clear_cache (see http://community.arm.com/groups/processors/blog/2010/02/17/caches-and-self-modifying-code for a decent example) and remember that the end address is *exclusive* so we can just use the end address passed in since it is always the byte after the actual last one needing flushing"
	self halt: #ceFlushICache