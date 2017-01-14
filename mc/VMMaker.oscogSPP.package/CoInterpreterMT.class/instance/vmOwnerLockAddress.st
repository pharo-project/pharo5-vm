cog jit support
vmOwnerLockAddress
	<api> "NB. For the JIT only, so it can generate the lock & unlock functions."
	<returnTypeC: #usqInt>
	^processHasThreadId
		ifTrue: [self cCode: '(usqInt)&GIV(vmOwnerLock)'
					inSmalltalk: [self inMemoryVMOwnerLockAddress]]
		ifFalse: [0]