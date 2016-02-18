bytecode generators
doubleExtendedDoAnythingBytecode
	"Replaces the Blue Book double-extended send [132], in which the first byte was wasted on 8 bits of argument count. 
	Here we use 3 bits for the operation sub-type (opType),  and the remaining 5 bits for argument count where needed. 
	The last byte give access to 256 instVars or literals. 
	See also secondExtendedSendBytecode"
	| opType |
	opType := byte1 >> 5.
	opType = 0 ifTrue:
		[^self genSend: byte2 numArgs: (byte1 bitAnd: 31)].
	opType = 1 ifTrue:
		[^self genSendSuper: byte2 numArgs: (byte1 bitAnd: 31)].
	"We need a map entry for this bytecode for correct parsing.
	 The sends will get an IsSend entry anyway.  The other cases need a fake one."
	opType caseOf: {
			[2]	->	[(coInterpreter isReadMediatedContextInstVarIndex: byte2)
						ifTrue: [self genPushMaybeContextReceiverVariable: byte2]
						ifFalse: [self genPushReceiverVariable: byte2]].
			[3]	->	[self genPushLiteralIndex: byte2].
			[4]	->	[self genPushLiteralVariable: byte2].
			[7]	->	[self genStorePop: false LiteralVariable: byte2.
					 self cppIf: IMMUTABILITY ifTrue: ["genStorePop:LiteralVariable: annotates; don't annotate twice" ^0]] }
		otherwise: "5 & 6"
			[(coInterpreter isWriteMediatedContextInstVarIndex: byte2)
				ifTrue: [self genStorePop: opType = 6 MaybeContextReceiverVariable: byte2]
				ifFalse: [self genStorePop: opType = 6 ReceiverVariable: byte2].
			 self cppIf: IMMUTABILITY ifTrue: ["genStorePop:...ReceiverVariable: annotate; don't annotate twice" ^0]].
	"We need a map entry for this bytecode for correct parsing (if the method builds a frame)."
	needsFrame ifTrue:
		[self annotateBytecode: self Label].
	^0