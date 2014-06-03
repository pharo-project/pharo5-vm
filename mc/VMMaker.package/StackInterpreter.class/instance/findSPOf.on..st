frame access
findSPOf: theFP on: thePage
	"Search for the stack pointer for theFP.  This points to the hottest item on the frame's stack.
	 DO NOT CALL THIS WITH theFP == localFP OR theFP == framePointer!"
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<returnTypeC: #'char *'>
	| theSP |
	<inline: false>
	<var: #theSP type: #'char *'>
	theSP := self findSPOrNilOf: theFP on: thePage startingFrom: thePage headFP.
	theSP notNil ifTrue:
		[^theSP].
	self error: 'did not find theFP in stack page'.
	^0