simulation stack
ssFlushTo: index nativeFlushTo: nativeIndex
	LowcodeVM ifTrue:
		[self ssNativeFlushTo: nativeIndex].
	0 to: methodOrBlockNumTemps - 1 do:
		[:i| self assert: ((self simStackAt: i) type = SSBaseOffset
						or: [self maybeCompilingFirstPassOfBlockWithInitialPushNil])].
	methodOrBlockNumTemps to: simSpillBase - 1 do:
		[:i| self assert: (self simStackAt: i) spilled].
	simSpillBase <= index ifTrue:
		[(simSpillBase max: methodOrBlockNumTemps) to: index do:
			[:i|
			self assert: needsFrame.
			(self simStackAt: i)
				ensureSpilledAt: (self frameOffsetOfTemporary: i)
				from: FPReg].
		 simSpillBase := index + 1]