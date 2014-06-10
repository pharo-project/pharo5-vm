debug printing
printFrame: theFP WithSP: theSP
	<api>
	| theMethod theMethodEnd numArgs numTemps rcvrAddress topThing |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<var: #addr type: #'char *'>
	<var: #rcvrAddress type: #'char *'>
	<var: #cogMethod type: #'CogBlockMethod *'>
	<var: #homeMethod type: #'CogMethod *'>
	self cCode: '' inSmalltalk: [self transcript ensureCr].
	(self isMachineCodeFrame: theFP)
		ifTrue:
			[| cogMethod homeMethod |
			 cogMethod := self mframeCogMethod: theFP.
			 homeMethod := self mframeHomeMethod: theFP.
			 theMethod := homeMethod asInteger.
			 theMethodEnd := homeMethod asInteger + homeMethod blockSize.
			 numArgs := cogMethod cmNumArgs.
			 numTemps := self temporaryCountOfMethodHeader: homeMethod methodHeader]
		ifFalse:
			[theMethod := self frameMethodObject: theFP.
			 theMethodEnd := theMethod + (objectMemory sizeBitsOfSafe: theMethod).
			 numArgs := self iframeNumArgs: theFP.
			 numTemps := self tempCountOf: theMethod].
	(self frameIsBlockActivation: theFP) ifTrue:
		[| rcvrOrClosure |
		 "No BlockLocalTempCounter in the Cogit's C code, so quick hack is to use numCopied + numArgs"
		 rcvrOrClosure := self pushedReceiverOrClosureOfFrame: theFP.
		 ((objectMemory isNonImmediate: rcvrOrClosure)
		 and: [(objectMemory addressCouldBeObj: rcvrOrClosure)
		 and: [(objectMemory fetchClassOfNonImm: rcvrOrClosure) = (objectMemory splObj: ClassBlockClosure)]])
			ifTrue: [numTemps := numArgs + (self stSizeOf: rcvrOrClosure)]
			ifFalse: [numTemps := numArgs]].
	self shortPrintFrame: theFP.
	(self isBaseFrame: theFP) ifTrue:
		[self printFrameOop: '(caller ctxt'
			at: theFP + (self frameStackedReceiverOffset: theFP) + (2 * BytesPerWord).
		 self printFrameOop: '(saved ctxt'
			at: theFP + (self frameStackedReceiverOffset: theFP) + (1 * BytesPerWord)].
	self printFrameOop: 'rcvr/clsr'
		at: theFP + FoxCallerSavedIP + ((numArgs + 1) * BytesPerWord).
	numArgs to: 1 by: -1 do:
		[:i|
		self printFrameOop: 'arg' index: numArgs - i at: theFP + FoxCallerSavedIP + (i * BytesPerWord)].
	self printFrameThing: 'caller ip'
		at: theFP + FoxCallerSavedIP
		extraString: ((stackPages longAt: theFP + FoxCallerSavedIP) = cogit ceReturnToInterpreterPC ifTrue:
						['ceReturnToInterpreter']).
	self printFrameThing: 'saved fp' at: theFP + FoxSavedFP.
	self printFrameMethodFor: theFP.
	(self isMachineCodeFrame: theFP) ifTrue:
		[self printFrameFlagsForFP: theFP].
	self printFrameOop: 'context' at: theFP + FoxThisContext.
	(self isMachineCodeFrame: theFP) ifFalse:
		[self printFrameFlagsForFP: theFP].
	(self isMachineCodeFrame: theFP)
		ifTrue: [rcvrAddress := theFP + FoxMFReceiver]
		ifFalse:
			[self printFrameThing: 'saved ip'
				at: theFP + FoxIFSavedIP
				extra: ((self iframeSavedIP: theFP) = 0
							ifTrue: [0]
							ifFalse: [(self iframeSavedIP: theFP) - theMethod + 2 - BaseHeaderSize]).
			 rcvrAddress := theFP + FoxIFReceiver].
	self printFrameOop: 'receiver' at: rcvrAddress.
	topThing := stackPages longAt: theSP.
	(topThing between: theMethod and: theMethodEnd)
		ifTrue:
			[rcvrAddress - BytesPerWord to: theSP + BytesPerWord by: BytesPerWord negated do:
				[:addr| | index |
				index := rcvrAddress - addr / BytesPerWord + numArgs.
				index <= numTemps
					ifTrue: [self printFrameOop: 'temp' index: index - 1 at: addr]
					ifFalse: [self printFrameOop: ((self frameIsBlockActivation: theFP)
													ifTrue: ['temp/stck']
													ifFalse: ['stck'])
								at: addr]].
			self printFrameThing: 'frame ip'
				at: theSP
				extra: ((self isMachineCodeFrame: theFP)
						ifTrue: [topThing - theMethod]
						ifFalse: [topThing - theMethod + 2 - BaseHeaderSize])]
		ifFalse:
			[rcvrAddress - BytesPerWord to: theSP by: BytesPerWord negated do:
				[:addr| | index |
				index := rcvrAddress - addr / BytesPerWord + numArgs.
				index <= numTemps
					ifTrue: [self printFrameOop: 'temp' index: index - 1 at: addr]
					ifFalse: [self printFrameOop: ((self frameIsBlockActivation: theFP)
													ifTrue: ['temp/stck']
													ifFalse: ['stck'])
								at: addr]]]