disassembly
blockDispatchFor: cogMethod perform: quaternaryFunction arg: arg
	"Evaluate quaternaryFunction with the block start mcpc, prev pc in block
	 dispatch, current pc in block dispatch and the supplied arg for each entry
	 in the block dispatch.  If the function answers non-zero answer the value
	 it answered. Used for disassembling blockDispatch."
	<doNotGenerate>
	| pc prevpc blockEntry end targetpc result |
	cogMethod blockEntryOffset = 0 ifTrue:
		[^nil].
	blockEntry := cogMethod blockEntryOffset + cogMethod asInteger.
	prevpc := pc := blockEntry.
	end := (self mapEndFor: cogMethod) - 1.
	[pc < end] whileTrue:
		[(backEnd isJumpAt: pc)
			ifTrue:
				[targetpc := backEnd jumpTargetPCAt: pc.
				 pc := pc + (backEnd instructionSizeAt: pc).
				 targetpc < blockEntry ifTrue:
					[result := self perform: quaternaryFunction
								with: targetpc
								with: prevpc
								with: pc
								with: arg.
					 result ~= 0 ifTrue:
						[^result].
					 prevpc := pc]]
			ifFalse:
				[pc := pc + (backEnd instructionSizeAt: pc)]].
	^0