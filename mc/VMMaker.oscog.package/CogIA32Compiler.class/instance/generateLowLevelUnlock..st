multi-threading
generateLowLevelUnlock: vmOwnerLockAddress
	vmOwnerLockAddress ~= 0 ifTrue:
		[cogit
			MoveCq: 0 R: EAX;
			MoveR: EAX Aw: vmOwnerLockAddress;
			gen: SFENCE].
	cogit RetN: 0