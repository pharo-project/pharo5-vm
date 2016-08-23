lazy become
followForwardedFrameContents: theFP stackPointer: theSP
	"follow pointers in the current stack frame up to theSP."
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<inline: false>
	 | oop |
	<var: #ptr type: #'char *'>
	theSP
		to: (self frameReceiverLocation: theFP)
		by: objectMemory wordSize
		do: [:ptr|
			oop := stackPages longAt: ptr.
			((objectMemory isNonImmediate: oop)
			 and: [objectMemory isForwarded: oop]) ifTrue:
				[stackPages longAt: ptr put: (objectMemory followForwarded: oop)]].
	theFP + FoxCallerSavedIP + objectMemory wordSize
		to: theFP + (self frameStackedReceiverOffset: theFP)
		by: objectMemory wordSize
		do: [:ptr|
			oop := stackPages longAt: ptr.
			((objectMemory isNonImmediate: oop)
			 and: [objectMemory isForwarded: oop]) ifTrue:
				[oop := objectMemory followForwarded: oop.
				 stackPages longAt: ptr put: oop]].
	"If we're in a block then also follow fields in the stacked closure as it may be activated again."
	(self frameIsBlockActivation: theFP) ifTrue:
		[self assert: oop = (stackPages longAt: theFP + (self frameStackedReceiverOffset: theFP)).
		 objectMemory followForwardedObjectFields: oop toDepth: 0].
	self assert: (objectMemory isForwarded: (self frameMethodObject: theFP)) not.
	(self frameHasContext: theFP) ifTrue:
		[self assert: (objectMemory isForwarded: (self frameContext: theFP)) not]