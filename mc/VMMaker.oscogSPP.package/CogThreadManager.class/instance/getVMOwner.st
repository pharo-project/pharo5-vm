public api
getVMOwner
	self sqLowLevelMFence.
	^vmOwner