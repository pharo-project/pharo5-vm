interpreter shell
incrementByteCount
	(byteCount := byteCount + 1) = breakCount ifTrue:
		[self doOrDefer: [self changed: #byteCountText; changed: #composeAll].
		 self halt].
	byteCount \\ 1000 = 0 ifTrue:
		[self doOrDefer: [self changed: #byteCountText; changed: #composeAll].
		 self forceInterruptCheck]