private
checkUnusedBytecodeSendsEnabled
	self class unusedBytecodeSendsEnabled ifFalse:
		[self error: 'unusedBytecode sends are not enabled.  continuting will likely crash the VM']