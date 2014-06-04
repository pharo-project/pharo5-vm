locking
tryLockVMToIndex: index
	"Attempt to lock the vmOwner to index, answering if successful."
	| vmThread locked |
	<var: #vmThread type: #'CogVMThread *'>
	self assert: index ~= 0.
	cogit tryLockVMOwner ifFalse: [^false].
	self getVMOwner = 0 ifTrue:
		[self setVMOwner: index.
		 cogit unlockVMOwner.
		 index >= 1 ifTrue:
			[vmThread := self vmThreadAt: index.
			 vmOSThread := vmThread osThread.
			 self sqLowLevelMFence].
		 ^true].
	(locked := index > 0 and: [self getVMOwner = index]) ifTrue:
		[vmThread := self vmThreadAt: index.
		 vmOSThread := vmThread osThread.
		 self sqLowLevelMFence].
	cogit unlockVMOwner.
	^locked