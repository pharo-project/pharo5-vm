inline cacheing
flushICacheFrom: startAddress "<Integer>" to: endAddress "<Integer>"
	<cmacro: '(me,startAddress,endAddress) ceFlushICache(startAddress,endAddress)'>
	self halt: #ceFlushICache