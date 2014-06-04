locking
testVMOwnerIs: index
	"Test what the vmOwner is from a process that may not be the current VM owner"
	| retryCount ownerIsIndex |
	self assert: index ~= 0.
	retryCount := 0.
	[cogit tryLockVMOwner] whileFalse:
		[(retryCount := retryCount + 1) > 10 ifTrue:
			[self ioTransferTimeslice]].
	ownerIsIndex := self getVMOwner = index.
	cogit unlockVMOwner.
	^ownerIsIndex