frame access
safeFindFrameAbove: theFP on: thePage startingFrom: startFrame
	"Search for the previous frame to theFP (the frame that theFP calls).
	 DO NOT CALL THIS WITH theFP == localFP OR theFP == framePointer!"
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #startFrame type: #'char *'>
	<returnTypeC: #'char *'>
	| aFrame prevFrame |
	<inline: true>
	<var: #aFrame type: #'char *'>
	<var: #prevFrame type: #'char *'>
	self assert: (stackPages isFree: thePage) not.
	startFrame = theFP ifTrue:
		[^nil].
	aFrame := startFrame.
	[prevFrame := aFrame.
	 aFrame := self frameCallerFP: aFrame.
	 aFrame ~= 0] whileTrue:
		[theFP = aFrame ifTrue:
			[^prevFrame]].
	^nil