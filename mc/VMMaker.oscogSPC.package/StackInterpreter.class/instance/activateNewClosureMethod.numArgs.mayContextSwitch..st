control primitives
activateNewClosureMethod: blockClosure numArgs: numArgs mayContextSwitch: mayContextSwitch
	"Similar to activateNewMethod but for Closure and newMethod."
	| numCopied outerContext theMethod closureIP |
	<inline: true>
	outerContext := objectMemory fetchPointer: ClosureOuterContextIndex ofObject: blockClosure.
	self assert: (objectMemory isContext: outerContext).
	numCopied := self copiedValueCountOfClosure: blockClosure.

	theMethod := objectMemory fetchPointer: MethodIndex ofObject: outerContext.
	self assert: (objectMemory isOopCompiledMethod: theMethod).
	self push: instructionPointer.
	self push: framePointer.
	framePointer := stackPointer.
	self push: theMethod.
	self push: (self encodeFrameFieldHasContext: false isBlock: true numArgs: numArgs).
	self push: objectMemory nilObject. "FxThisContext field"
	"Because inst var access is not checked, we must follow the receiver in Spur to ensure it is valid."
	self push: (objectMemory followField: ReceiverIndex ofObject: outerContext).

	"Copy the copied values..."
	0 to: numCopied - 1 do:
		[:i|
		self push: (objectMemory
					fetchPointer: i + ClosureFirstCopiedValueIndex
					ofObject: blockClosure)].

	self assert: (self frameIsBlockActivation: framePointer).
	self assert: (self frameHasContext: framePointer) not.

	"The initial instructions in the block nil-out remaining temps."

	"the instruction pointer is a pointer variable equal to 
	method oop + ip + BaseHeaderSize 
	-1 for 0-based addressing of fetchByte 
	-1 because it gets incremented BEFORE fetching currentByte"
	closureIP := self quickFetchInteger: ClosureStartPCIndex ofObject: blockClosure.
	instructionPointer := theMethod + closureIP + objectMemory baseHeaderSize - 2.
	self setMethod: theMethod.

	"Now check for stack overflow or an event (interrupt, must scavenge, etc)"
	stackPointer < stackLimit ifTrue:
		[self handleStackOverflowOrEventAllowContextSwitch: mayContextSwitch]