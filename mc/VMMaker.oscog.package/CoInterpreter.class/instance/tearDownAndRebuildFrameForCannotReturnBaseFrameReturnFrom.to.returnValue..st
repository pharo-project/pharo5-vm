return bytecodes
tearDownAndRebuildFrameForCannotReturnBaseFrameReturnFrom: contextToReturnFrom to: contextToReturnTo returnValue: returnValue
	"Handle the cannot return response for a base frame return to an invalid context.
	 Build a new base frame for the context in the cannot resume state ready for the
	 send of cannotReturn:.

	 Since we have returned from the base frame of the page the context is effectively widowed.
	 But its sender needs to be contextToReturnTo, and its pc needs to be the HasBeenReturnedFromMCPC
	 marker.  So bereave it (as a side-effect of isWidowedContext:), assign contextToReturnTo to
	 sender, and rebuild its frame, which will have the ceCannotResumePC as its pc.  Finally push
	 returnValue and set instructionPointer to ceCannotResumePC in preparation for the send."
	| newPage |
	<inline: false>
	<var: #newPage type: #'StackPage *'>
	self assert: (stackPage ~= 0 and: [stackPage isFree]).
	self isWidowedContext: contextToReturnFrom.
	self assert: (self isMarriedOrWidowedContext: contextToReturnFrom) not.
	objectMemory
		storePointer: SenderIndex ofObject: contextToReturnFrom withValue: contextToReturnTo;
		storePointer: InstructionPointerIndex ofObject: contextToReturnFrom withValue: HasBeenReturnedFromMCPCOop.
	"void the instructionPointer to stop it being incorrectly updated in a code
	 compaction in makeBaseFrameFor:."
	instructionPointer := 0.
	newPage := self makeBaseFrameFor: contextToReturnFrom.
	self assert: stackPage = newPage.
	self setStackPageAndLimit: newPage.
	framePointer := stackPage headFP.
	stackPointer := stackPage headSP.
	self assert: self stackTop = cogit ceCannotResumePC.
	"overwrite the ceSendCannotResumePC on the stack.  If ever re-executed
	 the returnValue will be taken from top-of-stack by ceCannotResume."
	self stackTopPut: returnValue.
	"Assign it to instructionPointer as externalCannotReturn:from: pushes it."
	instructionPointer := cogit ceCannotResumePC