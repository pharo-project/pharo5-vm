object memory support
noMarkedContextsOnPage: thePage
	"Answer true if there are no marked contexts on thePage."
	| theFP |
	<var: #thePage type: #'StackPage *'>
	<var: #theFP type: #'char *'>
	<inline: false>
	self assert: (stackPages isFree: thePage) not.
	theFP := thePage  headFP.
	[(self frameHasContext: theFP) ifTrue:
		[self assert: (objectMemory isContext: (self frameContext: theFP)).
		 (objectMemory isMarked: (self frameContext:  theFP)) ifTrue:
			[^false]].
	(theFP := self frameCallerFP: theFP) ~= 0] whileTrue.
	^true