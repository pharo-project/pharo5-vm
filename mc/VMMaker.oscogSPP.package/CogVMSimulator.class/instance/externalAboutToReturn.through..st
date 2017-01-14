return bytecodes
externalAboutToReturn: resultOop through: aContext
	self transcript ensureCr.
	self print: 'externalAboutToReturn: '; printOopShortInner: resultOop;
		print: ' through: '; printOopShortInner: aContext;
		print: ' in '; printActivationNameFor: (self frameMethodObject: framePointer)
					receiver: (self frameReceiver: framePointer)
					isBlock: (self frameIsBlockActivation: framePointer)
					firstTemporary: (self temporary: 0 in: framePointer);
		cr.
	^super externalAboutToReturn: resultOop through: aContext