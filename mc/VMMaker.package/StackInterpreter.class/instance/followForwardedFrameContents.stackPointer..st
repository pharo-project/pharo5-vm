lazy become
followForwardedFrameContents: theFP stackPointer: theSP
	"follow pointers in the current stack frame up to theSP."
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<var: #ptr type: #'char *'>
	theFP + (self frameStackedReceiverOffset: theFP)
		to: theFP + FoxCallerSavedIP + BytesPerWord
		by: BytesPerWord
		do: [:ptr| | oop |
			oop := stackPages longAt: ptr.
			((objectMemory isNonImmediate: oop)
			 and: [objectMemory isForwarded: oop]) ifTrue:
				[stackPages longAt: ptr put: (objectMemory followForwarded: oop)]].
	theSP
		to: (self frameReceiverOffset: theFP)
		by: BytesPerWord
		do: [:ptr| | oop |
			oop := stackPages longAt: ptr.
			((objectMemory isNonImmediate: oop)
			 and: [objectMemory isForwarded: oop]) ifTrue:
				[stackPages longAt: ptr put: (objectMemory followForwarded: oop)]].
	self assert: (objectMemory isForwarded: (self frameMethodObject: theFP)) not.
	(self frameHasContext: theFP) ifTrue:
		[self assert: (objectMemory isForwarded: (self frameContext: theFP)) not]