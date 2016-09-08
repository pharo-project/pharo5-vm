multi-threading
generateLowLevelTryLock: vmOwnerLockAddress
	"Generate a function that attempts to lock the vmOwnerLock and answers
	 true if it succeeded."
	vmOwnerLockAddress = 0 ifTrue:
		[cogit
			MoveCq: 1 R: EAX;
			RetN: 0.
		 ^self].
	cogit
		MoveCq: 1 R: EAX;
		gen: MFENCE; "make the XCHG globally consistent"
		gen: XCHGAwR operand: vmOwnerLockAddress operand: EAX;
		gen: SFENCE; "make the store globally visible"
		SubCq: 1 R: EAX; "Since we only ever set the lock to 1 or 0, subtracting 1 sets
						   EAX to 0 if the lock was already locked and non-zero if it wasn't."
		RetN: 0