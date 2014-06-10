object access primitives
unmarkAllFrames
	| thePage theFP flags |
	<var: #thePage type: #'StackPage *'>
	<var: #theFP type: #'char *'>
	<inline: false>
	0 to: numStackPages - 1 do:
		[:i|
		thePage := stackPages stackPageAt: i.
		(stackPages isFree: thePage) ifFalse:
			[theFP := thePage  headFP.
			 [flags := self longAt: theFP + FoxFrameFlags.
			  (flags bitAnd: 2) ~= 0 ifTrue:
				[self longAt: theFP + FoxFrameFlags put: flags - 2].
			  (theFP := self frameCallerFP: theFP) ~= 0] whileTrue]]