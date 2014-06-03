frame access
ensureFrameIsMarried: theFP SP: theSP
	<inline: true>
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	(self frameHasContext: theFP) ifTrue:
		[self assert: (objectMemory isContext: (self frameContext: theFP)).
		^self frameContext: theFP].

	^self marryFrame: theFP SP: theSP