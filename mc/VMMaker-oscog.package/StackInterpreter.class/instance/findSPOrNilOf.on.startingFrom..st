frame access
findSPOrNilOf: theFP on: thePage startingFrom: startFrame
	"Search for the stack pointer for theFP.  This points to the hottest item on the frame's stack.
	 DO NOT CALL THIS WITH theFP == localFP OR theFP == framePointer!"
	<var: #aFrame type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<returnTypeC: #'char *'>
	| aFrame theSP |
	<inline: true>
	<asmLabel: false>
	<var: #startFrame type: #'char *'>
	<var: #theSP type: #'char *'>
	self assert: (stackPages isFree: thePage) not.
	aFrame := startFrame.
	theSP := thePage headSP.
	aFrame = theFP ifTrue:
		[theSP >= aFrame ifTrue:
			["If the SP is invalid return the pointer to the receiver field."
			 ^self frameReceiverOffset: aFrame].
		 "Skip the instruction pointer on top of stack of inactive pages."
		^thePage = stackPage
			ifTrue: [theSP]
			ifFalse: [theSP + BytesPerWord]].
	[theSP := self frameCallerSP: aFrame.
	 aFrame := self frameCallerFP: aFrame.
	 aFrame ~= 0] whileTrue:
		[theFP = aFrame ifTrue:
			[^theSP]].
	^nil