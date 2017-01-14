method map
blockDispatchTargetsFor: cogMethod perform: binaryFunction arg: arg
	"Evaluate binaryFunction with the block start mcpc and supplied arg for each
	 entry in the block dispatch.  If the function answers non-zero answer the value
	 it answered.  Used to update back-references to the home method in compaction."
	<var: #cogMethod type: #'CogMethod *'>
	<var: #binaryFunction declareC: 'usqInt (*binaryFunction)(sqInt mcpc, sqInt arg)'>
	| pc blockEntry end targetpc result |
	cogMethod blockEntryOffset = 0 ifTrue:
		[^nil].
	blockEntry := cogMethod blockEntryOffset + cogMethod asInteger.
	pc := blockEntry.
	end := (self mapEndFor: cogMethod) - 1.
	[pc < end] whileTrue:
		[(backEnd isJumpAt: pc) ifTrue:
			[targetpc := backEnd jumpTargetPCAt: pc.
			 targetpc < blockEntry ifTrue:
				[result := self perform: binaryFunction
							with: targetpc
							with: arg.
				 result ~= 0 ifTrue:
					[^result]]].
		pc := pc + (backEnd instructionSizeAt: pc)].
	^0