simulation stack
ssFlushTo: index nativeFlushTo: nativeIndex
	LowcodeVM ifTrue: [ 
		self ssNativeFlushTo: nativeIndex.
	].
	methodOrBlockNumTemps to: simSpillBase - 1 do:
		[:i| self assert: (self simStackAt: i) spilled].
	simSpillBase <= index ifTrue:
		[(simSpillBase max: 0) to: index do:
			[:i|
			self assert: needsFrame.
			(self simStackAt: i)
				ensureSpilledAt: (self frameOffsetOfTemporary: i)
				from: FPReg].
		 simSpillBase := index + 1]