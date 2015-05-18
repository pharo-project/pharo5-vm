lazy become
followForwardedFrameContents: theFP stackPointer: theSP
	"follow pointers in the current stack frame up to theSP."
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<inline: false>
	<var: #ptr type: #'char *'>
	theSP
		to: (self frameReceiverLocation: theFP)
		by: objectMemory wordSize
		do: [:ptr| | oop |
			oop := stackPages longAt: ptr.
			((objectMemory isNonImmediate: oop)
			 and: [objectMemory isForwarded: oop]) ifTrue:
				[stackPages longAt: ptr put: (objectMemory followForwarded: oop)]].
	theFP + FoxCallerSavedIP + objectMemory wordSize
		to: theFP + (self frameStackedReceiverOffset: theFP)
		by: objectMemory wordSize
		do: [:ptr| | oop |
			oop := stackPages longAt: ptr.
			((objectMemory isNonImmediate: oop)
			 and: [objectMemory isForwarded: oop]) ifTrue:
				[stackPages longAt: ptr put: (objectMemory followForwarded: oop)]].
	self assert: (objectMemory isForwarded: (self frameMethodObject: theFP)) not.
	(self frameHasContext: theFP) ifTrue:
		[self assert: (objectMemory isForwarded: (self frameContext: theFP)) not]