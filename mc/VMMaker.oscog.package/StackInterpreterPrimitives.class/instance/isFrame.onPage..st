object access primitives
isFrame: aFrame onPage: aPage
	<var: #aFrame type: #'char *'>
	<var: #aPage type: #'StackPage *'>
	| theFP |
	<var: #theFP type: #'char *'>
	theFP := aPage headFP.
	[theFP = aFrame ifTrue: [^true].
	 theFP ~= aPage baseFP
	 and: [(stackPages stackPageFor: theFP) = aPage]] whileTrue:
		[theFP := self frameCallerFP: theFP].
	^false