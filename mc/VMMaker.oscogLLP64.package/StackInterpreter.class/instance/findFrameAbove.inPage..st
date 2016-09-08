frame access
findFrameAbove: theFP inPage: thePage
	"Answer the frame above theFP (adjacent frame nearest head end).
	 If theFP is the head frame answer 0."
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	| fp callerFP |
	<var: #fp type: #'char *'>
	<var: #callerFP type: #'char *'>
	<returnTypeC: #'char *'>
	fp := thePage headFP.
	fp = theFP ifTrue:
		[^0].
	[(callerFP := self frameCallerFP: fp) ~= 0] whileTrue:
		[callerFP = theFP ifTrue:
			[^fp].
		 fp := callerFP].
	self error: 'did not find theFP in stack page'.
	^0