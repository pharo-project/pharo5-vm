frame access
isFrame: aFrame onPage: aPage
	<var: #aFrame type: #'char *'>
	<var: #aPage type: #'StackPage *'>
	| theFP prevFP |
	<var: #theFP type: #'char *'>
	<var: #prevFP type: #'char *'>
	self deny: (stackPages isFree: aPage).
	"Walk the static chain making sure progress is being made,
	 and in the right direction, looking for a match with aFrame."
	theFP := aPage headFP.
	prevFP := theFP - objectMemory wordSize.
	[theFP = aFrame ifTrue: [^true].
	 theFP > prevFP
	 and: [theFP < aPage baseFP]] whileTrue:
		[prevFP := theFP.
		 theFP := self frameCallerFP: theFP].
	^false