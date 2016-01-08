trampoline support
evaluateTrampolineCallBlock: block protectLinkRegIfNot: inFrame
	<inline: true>
	inFrame 
		ifFalse: 
			[ backEnd saveAndRestoreLinkRegAround: [ block value ] ]
		ifTrue:
			[ block value ].