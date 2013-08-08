debug printing
shortPrintFrame: theFP
	<inline: false>
	<var: #theFP type: #'char *'>
	| rcvr |
	(stackPages couldBeFramePointer: theFP) ifFalse:
		[self print: 'invalid frame pointer'; cr.
		 ^nil].
	rcvr := self frameReceiver: theFP.
	self printHexPtr: theFP.
	self space.
	self printActivationNameFor: (self frameMethod: theFP)
		receiver: rcvr
		isBlock: (self frameIsBlockActivation: theFP)
		firstTemporary: (self temporary: 0 in: theFP).
	self space.
	self shortPrintOop: rcvr "shortPrintOop: adds a cr"