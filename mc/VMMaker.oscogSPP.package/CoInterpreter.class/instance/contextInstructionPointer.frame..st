frame access
contextInstructionPointer: theIP frame: theFP
	"Answer a value to store in the InstructionPointer index of a context object for theIP and theFP.
	 Mapping native pcs to bytecode pcs is quite expensive, requiring a search through the method
	 map.  We mitigate this cost by deferring mapping until we really have to, which is when a context's
	 instruction pointer is accessed by Smalltalk code (either direct inst var access or through the
	 instVarAt: primitive).  But to defer mapping we have to be able to distinguish machine code from
	 bytecode pcs, which we do by using negative values for machine code pcs.  So if the frame is a
	 machine code one answer the negation of the offset in the cog method.

	 As a whorish performance hack we also include the block method offset in the pc of a block.
	 The least significant 16 bits are the native pc and the most significant 14 bits are the block
	 start, in block alignment units.  So when mapping back we can find the start of the block.

	 See mustMapMachineCodePC:context: for the code that does the actual mapping."
	<var: #theFP type: #'char *'>
	<inline: false>
	self assert: (self validInstructionPointer: theIP inFrame: theFP).
	(self isMachineCodeFrame: theFP) ifTrue:
		[^self encodedNativePCOf: theIP cogMethod: (self mframeCogMethod: theFP)].
	^objectMemory integerObjectOf: (theIP = cogit ceReturnToInterpreterPC
							ifTrue: [self iframeSavedIP: theFP]
							ifFalse: [theIP])
						- (self iframeMethod: theFP)
						- objectMemory baseHeaderSize
						+ 2