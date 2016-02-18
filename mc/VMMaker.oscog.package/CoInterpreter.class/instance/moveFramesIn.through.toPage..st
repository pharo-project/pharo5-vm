frame access
moveFramesIn: oldPage through: theFP toPage: newPage
	"Move frames from the hot end of oldPage through to theFP to newPage.
	 This has the effect of making theFP a base frame which can be stored into.
	 Answer theFP's new location."
	| newSP newFP stackedReceiverOffset delta callerFP callerIP fpInNewPage offsetCallerFP theContext |
	<inline: false>
	<var: #oldPage type: #'StackPage *'>
	<var: #theFP type: #'char *'>
	<var: #newPage type: #'StackPage *'>
	<var: #newSP type: #'char *'>
	<var: #newFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	<var: #fpInNewPage type: #'char *'>
	<var: #offsetCallerFP type: #'char *'>
	<var: #source type: #'char *'>
	<returnTypeC: #'char *'>
	"A base frame must have a context for cannotReturn: processing."
	self assert: (self isBaseFrame: theFP) not.
	self assert: self validStackPageBaseFrames.
	callerFP := self frameCallerFP: theFP.
	self assert: (self frameHasContext: callerFP).
	self assert: (objectMemory isContext: (self frameContext: callerFP)).
	theContext := self ensureFrameIsMarried: theFP
					SP: theFP + ((self isMachineCodeFrame: theFP) ifTrue: [FoxMFReceiver] ifFalse: [FoxIFReceiver]).
	stackPages
		longAt: (newSP := newPage baseAddress) put: (self frameContext: callerFP);
		longAt: (newSP := newSP - objectMemory wordSize) put:  theContext.
	stackedReceiverOffset := self frameStackedReceiverOffset: theFP.
	"First move the data, leaving room for the caller and base frame contexts.  We will fix up frame pointers later."
	theFP + stackedReceiverOffset
		to: oldPage headSP
		by: objectMemory wordSize negated
		do: [:source|
			newSP := newSP - objectMemory wordSize.
			stackPages longAt: newSP put: (stackPages longAt: source)].
	"newSP = oldSP + delta => delta = newSP - oldSP"
	delta := newSP - oldPage headSP.
	newFP := newPage baseAddress - stackedReceiverOffset - (2 * objectMemory wordSize).
	self setHeadFP: oldPage headFP + delta andSP: newSP inPage: newPage.
	newPage baseFP: newFP.
	callerIP := self oopForPointer: (self frameCallerSavedIP: theFP).
	callerIP asUnsignedInteger >= objectMemory startOfMemory ifTrue:
		[self iframeSavedIP: callerFP put: callerIP.
		 callerIP := cogit ceReturnToInterpreterPC].
	stackPages longAt: theFP + stackedReceiverOffset put: callerIP.
	self assert: (callerFP < oldPage baseAddress
				and: [callerFP > (oldPage realStackLimit - (LargeContextSlots * objectMemory bytesPerOop / 2))]).
	oldPage
		headFP: callerFP;
		headSP: theFP + stackedReceiverOffset.
	"Mark the new base frame in the new page"
	stackPages
		longAt: newFP + FoxCallerSavedIP put: cogit ceBaseFrameReturnPC;
		longAt: newFP + FoxSavedFP put: 0.
	"Now relocate frame pointers, updating married contexts to refer to their moved spouse frames."
	fpInNewPage := newPage headFP.
	[offsetCallerFP := self frameCallerFP: fpInNewPage.
	 offsetCallerFP ~= 0 ifTrue:
		[offsetCallerFP := offsetCallerFP + delta].
	 stackPages longAt: fpInNewPage + FoxSavedFP put: (self oopForPointer: offsetCallerFP).
	 (self frameHasContext: fpInNewPage) ifTrue:
		[theContext := self frameContext: fpInNewPage.
		 objectMemory storePointerUnchecked: SenderIndex
			ofObject: theContext
			withValue: (self withSmallIntegerTags: fpInNewPage).
		 objectMemory storePointerUnchecked: InstructionPointerIndex
			ofObject: theContext
			withValue: (self withSmallIntegerTags: offsetCallerFP)].
	 fpInNewPage := offsetCallerFP.
	 fpInNewPage ~= 0] whileTrue.
	self assert: self validStackPageBaseFrames.
	^newFP