bytecode generator support
mergePoppingWithEntryInTargetSimStack: mergeSimStack at: i
	"Merge an intermediate result on currentSimStack with the corresponding one in target's mergeSimStack.
	 Depending on spilledness, the stack may need to be pushed or popped, or simply a register assignment made."
	| currentEntry targetEntry |
	<inline: true>
	currentEntry := self simStack: simStack at: i.
	targetEntry := self simStack: mergeSimStack at: i.
	currentEntry reconcilePoppingWith: targetEntry.
	 "Note, we could update the simStack and spillBase here but that is done in restoreSimStackAtMergePoint:
	 spilled ifFalse:
		[simSpillBase := i - 1].
	 simStack
		at: i
		put: (self
				cCode: [mergeSimStack at: i]
				inSmalltalk: [(mergeSimStack at: i) copy])"