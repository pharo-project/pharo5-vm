debug printing
printFrame: theFP WithSP: theSP
	<api>
	| theMethod numArgs topThing |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<var: #addr type: #'char *'>
	self cCode: '' inSmalltalk: [self transcript ensureCr].
	theMethod := self frameMethod: theFP.
	numArgs := self frameNumArgs: theFP.
	self shortPrintFrame: theFP.
	self printFrameOop: 'rcvr/clsr'
		at: theFP + FoxCallerSavedIP + ((numArgs + 1) * BytesPerWord).
	numArgs to: 1 by: -1 do:
		[:i| self printFrameOop: 'arg' at: theFP + FoxCallerSavedIP + (i * BytesPerWord)].
	self printFrameThing: 'cllr ip/ctxt' at: theFP + FoxCallerSavedIP.
	self printFrameThing: 'saved fp' at: theFP + FoxSavedFP.
	self printFrameOop: 'method' at: theFP + FoxMethod.
	self printFrameFlagsForFP: theFP.
	self printFrameThing: 'context' at: theFP + FoxThisContext.
	self printFrameOop: 'receiver' at: theFP + FoxReceiver.
	topThing := stackPages longAt: theSP.
	(topThing >= theMethod
	 and: [topThing <= (theMethod + (objectMemory sizeBitsOfSafe: theMethod))])
		ifTrue:
			[theFP + FoxReceiver - BytesPerWord to: theSP + BytesPerWord by: BytesPerWord negated do:
				[:addr|
				self printFrameOop: 'temp/stck' at: addr].
			self printFrameThing: 'frame ip' at: theSP]
		ifFalse:
			[theFP + FoxReceiver - BytesPerWord to: theSP by: BytesPerWord negated do:
				[:addr|
				self printFrameOop: 'temp/stck' at: addr]]