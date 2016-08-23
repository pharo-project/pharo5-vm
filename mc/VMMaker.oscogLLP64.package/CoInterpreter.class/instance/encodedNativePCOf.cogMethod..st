frame access
encodedNativePCOf: mcpc cogMethod: cogMethod
	"Encode the mcpc in cogMethod as a value that can be stashed in a context.
	 Mapping native pcs to bytecode pcs is quite expensive, requiring a search
	 through the method map.  We mitigate this cost by deferring mapping until
	 we really have to, which is when a context's instruction pointer is accessed
	 by Smalltalk code.  But to defer mapping we have to be able to distinguish
	 machine code from bytecode pcs, which we do by using negative values for
	 machine code pcs.

	 As a whorish performance hack we also include the block method offset in
	 the pc of a block. The least significant 16 bits are the native pc and the most
	 significant 15 bits are the block start, in block alignment units.  So when
	 mapping back we can find the start of the block.

	 See mustMapMachineCodePC:context: for the code that does the actual mapping."
	<var: #cogMethod type: #'CogBlockMethod *'>
	| homeMethod blockOffset |
	<var: #homeMethod type: #'CogMethod *'>
	mcpc = cogit ceCannotResumePC ifTrue:
		[^HasBeenReturnedFromMCPCOop].
	cogMethod cmType = CMMethod ifTrue:
		[^objectMemory integerObjectOf: cogMethod asInteger - mcpc].
	homeMethod := cogMethod cmHomeMethod.
	blockOffset := homeMethod asInteger - cogMethod asInteger / cogit blockAlignment.
	^objectMemory integerObjectOf: ((blockOffset bitShift: 16) bitOr: (cogMethod asInteger - mcpc bitAnd: 16rFFFF))