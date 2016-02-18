trampolines
ceActiveContext
	<api>
	<option: #SqueakV3ObjectMemory>
	"Since the trampoline checks for marriage we should only be here for a single frame."
	self assert: (self isMachineCodeFrame: framePointer).
	self assert: (self frameHasContext: framePointer) not.
	"Do *not* include the return pc in the stack contents; hence + BytesPerWord"
	^self marryFrame: framePointer SP: stackPointer + objectMemory wordSize