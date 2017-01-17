jump bytecodes
ifBackwardsCheckForEvents: offset
	"Backward jump means we're in a loop.
		- check for possible interrupts.
		- check for long-running loops and JIT if appropriate."
	| switched backwardJumpCountByte |
	<inline: true>
	offset >= 0 ifTrue:
		[^self].

	localSP < stackLimit ifTrue:
		[self externalizeIPandSP.
		 switched := self checkForEventsMayContextSwitch: true.
		 self returnToExecutive: true postContextSwitch: switched.
		 self browserPluginReturnIfNeeded.
		 self internalizeIPandSP.
		 switched ifTrue:
			[^self]].

	"We use the least significant byte of the flags word (which is marked as an immediate) and
	 subtract two each time to avoid disturbing the least significant tag bit.  Since the byte is
	 initialized to 1 (on frame build), on first decrement it will become -1.  Trip when it reaches 1 again."
	backwardJumpCountByte := self iframeBackwardBranchByte: localFP.
	(backwardJumpCountByte := backwardJumpCountByte - 2) = 1
		ifTrue:
			[(self methodWithHeaderShouldBeCogged: (objectMemory methodHeaderOf: method)) ifTrue:
				[self externalizeIPandSP.
				 self attemptToSwitchToMachineCode: (self oopForPointer: localIP) - offset - method - objectMemory baseHeaderSize - 1
				 "If attemptToSwitchToMachineCode: returns the method could not be cogged, hence..."].
			 "can't cog method; avoid asking to cog it again for the longest possible time."
			 backwardJumpCountByte := 16r7F]
		ifFalse:
			[backwardJumpCountByte = -1 ifTrue: "initialize the count"
				[self assert: minBackwardJumpCountForCompile <= 128.
				 backwardJumpCountByte := minBackwardJumpCountForCompile - 1 << 1 + 1]].
	self iframeBackwardBranchByte: localFP put: backwardJumpCountByte