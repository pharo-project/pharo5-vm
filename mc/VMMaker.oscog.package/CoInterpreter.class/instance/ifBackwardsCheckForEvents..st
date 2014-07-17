jump bytecodes
ifBackwardsCheckForEvents: offset
	"Backward jump means we're in a loop.
		- check for possible interrupts.
		- check for long-running loops and JIT if appropriate."
	| switched backwardJumpCountByte |
	<inline: true>
	offset < 0 ifTrue:
		[localSP < stackLimit ifTrue:
			[self externalizeIPandSP.
			 switched := self checkForEventsMayContextSwitch: true.
			 self returnToExecutive: true postContextSwitch: switched.
			 self browserPluginReturnIfNeeded.
			 self internalizeIPandSP].
		 "We use the least significant byte of the flags word (which is marked as an immediate) and subtract two each time
		  to avoid disturbing the least significant tag bit.  Since the byte is initialized to 1 (on frame build), on first decrement
		  it will become -1.  We trip when it becomes 1 again."
		 backwardJumpCountByte := stackPages byteAt: localFP + (VMBIGENDIAN ifTrue: [FoxIFrameFlags + BytesPerWord - 1] ifFalse: [FoxIFrameFlags]).
		 (backwardJumpCountByte := backwardJumpCountByte - 2) <= 1 ifTrue:
			[backwardJumpCountByte = -1
				ifTrue: "initialize the count"
					[self assert: minBackwardJumpCountForCompile <= 128.
					 backwardJumpCountByte := minBackwardJumpCountForCompile - 1 << 1 + 1]
				ifFalse:
					[(self methodWithHeaderShouldBeCogged: (self headerOf: method))
						ifTrue:
							[self externalizeFPandSP.
							 self attemptToSwitchToMachineCode: (self oopForPointer: localIP) - offset - method - BaseHeaderSize - 1]
						ifFalse: "avoid asking for as long as possible"
							[backwardJumpCountByte := 16rFF]]].
		 stackPages
			byteAt: localFP + (VMBIGENDIAN ifTrue: [FoxIFrameFlags + BytesPerWord - 1] ifFalse: [FoxIFrameFlags])
			put: backwardJumpCountByte]