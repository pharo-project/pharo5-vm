frame access
findSPOrNilOf: theFP on: thePage startingFrom: startFrame
	"Search for the stack pointer for theFP.  This points to the hottest item on the frame's stack.
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
		[thePage headSP >= startFrame ifTrue:
			["If the SP is invalid return the pointer to the receiver field."
			 ^self frameReceiverLocation: theFP].
		 "Skip the instruction pointer on top of stack of inactive pages."
		^thePage = stackPage
			ifTrue: [thePage headSP]
			ifFalse: [thePage headSP + objectMemory wordSize]].
	aFrame := startFrame.
	[prevFrame := aFrame.
	 aFrame := self frameCallerFP: aFrame.
	 aFrame ~= 0] whileTrue:
		[theFP = aFrame ifTrue:
			[^self frameCallerSP: prevFrame]].
	^nil