jump bytecodes
ifBackwardsCheckForEvents: offset
	"Backward jump means we're in a loop.
		- check for possible interrupts.
		- check for long-running loops and JIT if appropriate."
	| switched |
	<inline: true>
	offset < 0 ifTrue:
		[localSP < stackLimit ifTrue:
			[self externalizeIPandSP.
			 switched := self checkForEventsMayContextSwitch: true.
			 self returnToExecutive: true postContextSwitch: switched.
			 self browserPluginReturnIfNeeded.
			 self internalizeIPandSP].
		method = lastBackwardJumpMethod
			ifTrue:
				[(backwardJumpCount := backwardJumpCount - 1) <= 0 ifTrue:
					[(self methodWithHeaderShouldBeCogged: (self headerOf: method))
						ifTrue:
							[self externalizeFPandSP.
							 self resetBackwardJumpVariables. "only to force variables to be global"
							 self attemptToSwitchToMachineCode: (self oopForPointer: localIP) - offset - method - BaseHeaderSize - 1]
						ifFalse: "don't ask if one should compile a second time..."
							[backwardJumpCount := 1 << (BytesPerWord * 8 - 2)]]]
			ifFalse:
				[lastBackwardJumpMethod := method.
				backwardJumpCount := minBackwardJumpCountForCompile]]