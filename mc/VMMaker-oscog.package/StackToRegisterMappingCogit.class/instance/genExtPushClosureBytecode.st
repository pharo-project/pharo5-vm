bytecode generators
genExtPushClosureBytecode
	"Block compilation.  At this point in the method create the block.  Note its start
	 and defer generating code for it until after the method and any other preceeding
	 blocks.  The block's actual code will be compiled later."
	"253		11111101 eei i i kkk	jjjjjjjj		Push Closure Num Copied iii (+ Ext A // 16 * 8) Num Args kkk (+ Ext A \\ 16 * 8) BlockSize jjjjjjjj (+ Ext B * 256). ee = num extensions"
	| numArgs numCopied |
	self assert: needsFrame.
	self addBlockStartAt: bytecodePC + 3 "0 relative"
		numArgs: (numArgs := (byte1 bitAnd: 16r7) + (extA \\ 16 * 8))
		numCopied: (numCopied := ((byte1 >> 3) bitAnd: 7) + (extA // 16 * 8))
		span: byte2 + (extB << 8).
	extA := extB := 0.
	numCopied > 0 ifTrue:
		[self ssFlushTo: simStackPtr].
	optStatus isReceiverResultRegLive: false.
	self ssAllocateCallReg: SendNumArgsReg and: ReceiverResultReg.
	"see ceClosureCopyDescriptor:"
	self MoveCq: numArgs + (numCopied << 6) + (bytecodePC + 4 "1 relative" << 12) R: SendNumArgsReg.
	self CallRT: ceClosureCopyTrampoline.
	numCopied > 0 ifTrue:
		[self AddCq: numCopied * BytesPerWord R: SPReg.
		 self ssPop: numCopied].
	^self ssPushRegister: ReceiverResultReg