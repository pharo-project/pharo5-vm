bytecode generator support
flushLiveRegistersForSend
	<inline: true>
	self assert: simSelf type = SSBaseOffset.
	simSelf liveRegister: NoReg.
	0 to: simStackPtr do:
		[:i|
		 self assert: ((self simStackAt: i) spilled
					 and: [(self simStackAt: i) type = SSConstant
						or: [((self simStackAt: i) type = SSBaseOffset
							or: [i >= methodOrBlockNumTemps
								and: [(self simStackAt: i) type = SSSpill]])
							 and: [(self simStackAt: i) register = FPReg
							 and: [(self simStackAt: i) offset = (self frameOffsetOfTemporary: i)]]]]).
		 (self simStackAt: i) liveRegister: NoReg]