frame access
divorceAllFrames
	| activeContext |
	<inline: false>
	<var: #aPage type: #'StackPage *'>
	stackPage ~= 0 ifTrue:
		[self externalWriteBackHeadFramePointers].
	activeContext := self
						ensureFrameIsMarried: framePointer
						SP: stackPointer + objectMemory wordSize.
	0 to: numStackPages - 1 do:
		[:i| | aPage |
		aPage := stackPages stackPageAt: i.
		(stackPages isFree: aPage) ifFalse:
			[self divorceFramesIn: aPage]].
	self zeroStackPage.
	^activeContext