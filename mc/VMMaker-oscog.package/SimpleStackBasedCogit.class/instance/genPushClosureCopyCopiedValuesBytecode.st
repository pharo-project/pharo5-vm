bytecode generators
genPushClosureCopyCopiedValuesBytecode
	"Block compilation.  At this point in the method create the block.  Note its start
	 and defer generating code for it until after the method and any other preceeding
	 blocks.  The block's actual code will be compiled later."
	"143   10001111 llllkkkk jjjjjjjj iiiiiiii	Push Closure Num Copied llll Num Args kkkk BlockSize jjjjjjjjiiiiiiii"
	| numArgs numCopied |
	self assert: needsFrame.
	self addBlockStartAt: bytecodePC + 4 "0 relative"
		numArgs: (numArgs := byte1 bitAnd: 16rF)
		numCopied: (numCopied := byte1 >> 4)
		span: (byte2 << 8) + byte3.
	"see ceClosureCopyDescriptor:"
	self MoveCq: numArgs + (numCopied << 6) + (bytecodePC + 5 "1 relative" << 12) R: SendNumArgsReg.
	self CallRT: ceClosureCopyTrampoline.
	numCopied > 0
		ifTrue:
			[numCopied > 1 ifTrue:
				[self AddCq: (numCopied - 1) * BytesPerWord R: SPReg].
			 self MoveR: ReceiverResultReg Mw: 0 r: SPReg]
		ifFalse:
			[self PushR: ReceiverResultReg].
	^0