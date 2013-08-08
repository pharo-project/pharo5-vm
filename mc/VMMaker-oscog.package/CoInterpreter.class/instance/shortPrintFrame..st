debug printing
shortPrintFrame: theFP
	<inline: false>
	<var: #theFP type: #'char *'>
	| rcvr mthd |
	(stackPages couldBeFramePointer: theFP) ifFalse:
		[self print: 'invalid frame pointer'; cr.
		 ^nil].
	rcvr := self frameReceiver: theFP.
	mthd := self frameMethodObject: theFP.
	self printHexPtr: theFP.
	self space.
	self printChar: ((self isMachineCodeFrame: theFP) ifTrue: [$M] ifFalse: [$I]).
	self space.
	self printActivationNameFor: mthd
		receiver: rcvr
		isBlock: (self frameIsBlockActivation: theFP)
		firstTemporary: (self temporary: 0 in: theFP).
	self space.
	self shortPrintOop: rcvr "shortPrintOop: adds a cr"