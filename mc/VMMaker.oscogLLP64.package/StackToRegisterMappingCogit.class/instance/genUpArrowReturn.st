bytecode generators
genUpArrowReturn
	"Generate a method return from within a method or a block.
	 Frameless method activation looks like
	 CISCs (x86):
				receiver
				args
		sp->	ret pc.
	 RISCs (ARM):
				receiver
				args
				ret pc in LR.
	 A fully framed activation is described in CoInterpreter class>initializeFrameIndices.
	 Return pops receiver and arguments off the stack.  Callee pushes the result."
	| framelessReturn |
	deadCode := true. "can't fall through"
	inBlock > 0 ifTrue:
		[self assert: needsFrame. 
		 self CallRT: ceNonLocalReturnTrampoline.
		 self annotateBytecode: self Label.
		 ^0].
	self 
		cppIf: IMMUTABILITY
		ifTrue: [framelessReturn := needsFrame and: [useTwoPaths not]]
		ifFalse: [framelessReturn := needsFrame].
	framelessReturn
		ifTrue:
			[
			 LowcodeVM ifTrue: [ hasNativeFrame ifTrue: [ self leaveNativeFrame ] ].
			 self MoveR: FPReg R: SPReg.
			 self PopR: FPReg.
			 backEnd hasLinkRegister ifTrue:
				[self PopR: LinkReg].
			 self RetN: methodOrBlockNumArgs + 1 * objectMemory wordSize]
		ifFalse:
			[self RetN: ((methodOrBlockNumArgs > self numRegArgs
						"A method with an interpreter prim will push its register args for the prim.  If the failure
						 body is frameless the args must still be popped, see e.g. Behavior>>nextInstance."
						or: [regArgsHaveBeenPushed])
							ifTrue: [methodOrBlockNumArgs + 1 * objectMemory wordSize]
							ifFalse: [0])].
	^0