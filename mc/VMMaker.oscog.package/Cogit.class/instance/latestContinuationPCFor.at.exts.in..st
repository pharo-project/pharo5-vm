compile abstract instructions
latestContinuationPCFor: descriptor at: pc exts: nExts in: aMethodObj
	"Assuming the descriptor is that for a branch or block,
	 answer the furthest reachable pc for this bytecode."
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<inline: true>
	| distance |
	distance := self spanFor: descriptor at: pc exts: nExts in: aMethodObj.
	^pc + descriptor numBytes + (distance max: 0)