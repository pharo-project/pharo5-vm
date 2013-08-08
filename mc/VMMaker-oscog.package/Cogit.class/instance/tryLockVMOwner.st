multi-threading
tryLockVMOwner
	<api>
		"ceTryLockVMOwner does an atomic swap of the lock with 1 and
		 then subtracts 1from lock's value.  So if the result is 0 the lock was
		 already held.  Anything else (in fact -1) implies we hold the lock."
	<cmacro: '() (ceTryLockVMOwner() != 0)'>
	^(self simulateLeafCallOf: ceTryLockVMOwner) ~= 0