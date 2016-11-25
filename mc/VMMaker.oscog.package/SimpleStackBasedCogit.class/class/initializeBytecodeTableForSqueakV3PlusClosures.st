class initialization
initializeBytecodeTableForSqueakV3PlusClosures
	"SimpleStackBasedCogit initializeBytecodeTableForSqueakV3PlusClosures"

	FirstSpecialSelector := 176.
	NumSpecialSelectors := 32.
	self flag:
'Special selector send class must be inlined to agree with the interpreter, which
 inlines class.  If class is sent to e.g. a general instance of ProtoObject then unless
 class is inlined there will be an MNU.  It must be that the Cointerpreter and Cogit
 have identical semantics.  We get away with not hardwiring the other special
 selectors either because in the Cointerpreter they are not inlined or because they
 are inlined only to instances of classes for which there will always be a method.'.
	self generatorTableFrom: #(
		(1    0   15 genPushReceiverVariableBytecode isInstVarRef)
		(1  16   31 genPushTemporaryVariableBytecode)
		(1  32   63 genPushLiteralConstantBytecode needsFrameNever: 1)
		(1  64   95 genPushLiteralVariableBytecode needsFrameNever: 1)
		(1  96 103 genStoreAndPopReceiverVariableBytecode isInstVarRef isMappedIfImmutability needsFrameIfImmutability: -1)
		(1 104 111 genStoreAndPopTemporaryVariableBytecode)
		(1 112 112 genPushReceiverBytecode)
		(1 113 113 genPushConstantTrueBytecode needsFrameNever: 1)
		(1 114 114 genPushConstantFalseBytecode needsFrameNever: 1)
		(1 115 115 genPushConstantNilBytecode needsFrameNever: 1)
		(1 116 119 genPushQuickIntegerConstantBytecode needsFrameNever: 1)
		"method returns in blocks need a frame because of nonlocalReturn:through:"
		(1 120 120 genReturnReceiver				return needsFrameIfInBlock: isMappedInBlock 0)
		(1 121 121 genReturnTrue					return needsFrameIfInBlock: isMappedInBlock 0)
		(1 122 122 genReturnFalse					return needsFrameIfInBlock: isMappedInBlock 0)
		(1 123 123 genReturnNil					return needsFrameIfInBlock: isMappedInBlock 0)
		(1 124 124 genReturnTopFromMethod		return needsFrameIfInBlock: isMappedInBlock -1)
		(1 125 125 genReturnTopFromBlock		return needsFrameNever: -1)

		(1 126 127 unknownBytecode)

		(2 128 128 extendedPushBytecode isInstVarRef) "well, maybe inst var ref"
		(2 129 129 extendedStoreBytecode isInstVarRef isMappedIfImmutability) "well, maybe inst var ref"
		(2 130 130 extendedStoreAndPopBytecode isInstVarRef isMappedIfImmutability) "well, maybe inst var ref"
		(2 131 131 genExtendedSendBytecode isMapped)
		(3 132 132 doubleExtendedDoAnythingBytecode isInstVarRef isMapped) "well, maybe inst var ref"
		(2 133 133 genExtendedSuperBytecode isMapped)
		(2 134 134 genSecondExtendedSendBytecode isMapped)
		(1 135 135 genPopStackBytecode needsFrameNever: -1)
		(1 136 136 duplicateTopBytecode needsFrameNever: 1)

		(1 137 137 genPushActiveContextBytecode)
		(2 138 138 genPushNewArrayBytecode)),

		((initializationOptions at: #SpurObjectMemory ifAbsent: [false])
			ifTrue: [#((3 139 139 genCallPrimitiveBytecode))]
			ifFalse: [#((1 139 139 unknownBytecode))]),

	  #(
		(3 140 140 genPushRemoteTempLongBytecode)
		(3 141 141 genStoreRemoteTempLongBytecode)
		(3 142 142 genStoreAndPopRemoteTempLongBytecode)
		(4 143 143 genPushClosureCopyCopiedValuesBytecode block v3:Block:Code:Size:)

		(1 144 151 genShortUnconditionalJump			branch v3:ShortForward:Branch:Distance:)
		(1 152 159 genShortJumpIfFalse					branch isBranchFalse isMapped "because of mustBeBoolean"
															v3:ShortForward:Branch:Distance:)
		(2 160 163 genLongUnconditionalBackwardJump	branch isMapped "because of interrupt check"
															v3:Long:Branch:Distance:)
		(2 164 167 genLongUnconditionalForwardJump		branch v3:Long:Branch:Distance:)
		(2 168 171 genLongJumpIfTrue					branch isBranchTrue isMapped "because of mustBeBoolean"
															v3:LongForward:Branch:Distance:)
		(2 172 175 genLongJumpIfFalse					branch isBranchFalse isMapped "because of mustBeBoolean"
															v3:LongForward:Branch:Distance:)

		(1 176 197 genSpecialSelectorSend isMapped)
		(1 198 198 genSpecialSelectorEqualsEquals needsFrameNever: notMapped -1) "not mapped because it is directly inlined (for now)"
		(1 199 199 genSpecialSelectorClass needsFrameNever: notMapped 0) "not mapped because it is directly inlined (for now)"
		(1 200 200 genSpecialSelectorNotEqualsEquals needsFrameNever: notMapped -1) "not mapped because it is directly inlined (for now)"
		(1 201 207 genSpecialSelectorSend isMapped)
		(1 208 223 genSendLiteralSelector0ArgsBytecode isMapped)
		(1 224 239 genSendLiteralSelector1ArgBytecode isMapped)
		(1 240 255 genSendLiteralSelector2ArgsBytecode isMapped))