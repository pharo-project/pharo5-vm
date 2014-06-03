frame access
frameCallerSP: theFP
	"Answer the SP of the caller provided theFP is not a base frame.
	 This points to the hottest item on the caller frame's stack."
	<var: #theFP type: #'char *'>
	<returnTypeC: 'char *'>
	<asmLabel: false>
	self assert: (self isBaseFrame: theFP) not.
	^theFP + (self frameStackedReceiverOffset: theFP) + BytesPerWord