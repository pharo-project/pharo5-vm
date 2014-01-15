frame access
divorceAllFrames
	| activeContext |
	<inline: false>
	<var: #aPage type: #'StackPage *'>
	self externalWriteBackHeadFramePointers.
	activeContext := self ensureFrameIsMarried: framePointer SP: stackPointer.
	0 to: numStackPages - 1 do:
		[:i| | aPage |
		aPage := stackPages stackPageAt: i.
		(stackPages isFree: aPage) ifFalse:
			[self divorceFramesIn: aPage]].
	stackPage := 0.
	^activeContext