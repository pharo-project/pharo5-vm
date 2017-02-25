object access primitives
unmarkAllFrames
	| thePage theFP methodField flags |
	<var: #thePage type: #'StackPage *'>
	<var: #theFP type: #'char *'>
	<inline: false>
	0 to: numStackPages - 1 do:
		[:i|
		thePage := stackPages stackPageAt: i.
		(stackPages isFree: thePage) ifFalse:
			[theFP := thePage  headFP.
			 [methodField := stackPages longAt: theFP + FoxMethod.
			 methodField asUnsignedInteger < objectMemory startOfMemory
				ifTrue:
					[(methodField bitAnd: 4) ~= 0 ifTrue:
						[self longAt: theFP + FoxMethod put: methodField - 4]]
				ifFalse:
					[flags := stackPages longAt: theFP + FoxIFrameFlags.
					  (flags bitAnd: 2) ~= 0 ifTrue:
						[stackPages longAt: theFP + FoxIFrameFlags put: flags - 2]].
			  (theFP := self frameCallerFP: theFP) ~= 0] whileTrue]]