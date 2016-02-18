compiled methods
endPCOf: aMethod
	"Determine the endPC of a method in the heap using interpretation that looks for returns."
	
	<var: #descriptor type: #'BytecodeDescriptor *'>
	| pc end farthestContinuation prim encoderClass inst is |
	(prim := self primitiveIndexOf: aMethod) > 0 ifTrue:
		[(self isQuickPrimitiveIndex: prim) ifTrue:
			[^(self startPCOfMethod: aMethod) - 1]].
	encoderClass := self encoderClassForHeader: (objectMemory methodHeaderOf: aMethod).
	is := (InstructionStream
			on: (VMCompiledMethodProxy new
					for: aMethod
					coInterpreter: self
					objectMemory: objectMemory)).
	pc := farthestContinuation := self startPCOfMethod: aMethod.
	end := objectMemory numBytesOf: aMethod.
	is pc: pc + 1.
	[pc <= end] whileTrue:
		[inst := encoderClass interpretNextInstructionFor: MessageCatcher new in: is.
		 inst selector
			caseOf: {
				 [#pushClosureCopyNumCopiedValues:numArgs:blockSize:]	
											->	[is pc: is pc + inst arguments last.
												 farthestContinuation := farthestContinuation max: pc].
				 [#jump:]					->	[farthestContinuation := farthestContinuation max: pc + inst arguments first].
				 [#jump:if:]					->	[farthestContinuation := farthestContinuation max: pc + inst arguments first].
				 [#methodReturnConstant:]	->	[pc >= farthestContinuation ifTrue: [end := pc]].
				 [#methodReturnReceiver]	->	[pc >= farthestContinuation ifTrue: [end := pc]].
				 [#methodReturnTop]		->	[pc >= farthestContinuation ifTrue: [end := pc]] }
			otherwise: [].
		 pc := is pc - 1].
	^end