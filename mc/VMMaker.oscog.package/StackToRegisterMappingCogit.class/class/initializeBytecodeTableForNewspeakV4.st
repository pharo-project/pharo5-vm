class initialization
initializeBytecodeTableForNewspeakV4
	"StackToRegisterMappingCogit initializeBytecodeTableForNewspeakV4"

	numPushNilsFunction := #v4:Num:Push:Nils:.
	pushNilSizeFunction := #v4PushNilSize:numInitialNils:.
	NSSendIsPCAnnotated := true. "IsNSSendCall used by SendAbsentImplicit"
	FirstSpecialSelector := 80.
	NumSpecialSelectors := 32.
	self flag:
'Special selector send class must be inlined to agree with the interpreter, which
 inlines class.  If class is sent to e.g. a general instance of ProtoObject then unless
 class is inlined there will be an MNU.  It must be that the Cointerpreter and Cogit
 have identical semantics.  We get away with not hardwiring the other special
 selectors either because in the Cointerpreter they are not inlined or because they
 are inlined only to instances of classes for which there will always be a method.'.
	self generatorTableFrom: #(
		"1 byte bytecodes"
		(1    0   15 genPushReceiverVariableBytecode isInstVarRef needsFrameNever: 1)
		(1  16   31 genPushLiteralVariable16CasesBytecode needsFrameNever: 1)
		(1  32   63 genPushLiteralConstantBytecode needsFrameNever: 1)
		(1  64   75 genPushTemporaryVariableBytecode needsFrameIfMod16GENumArgs: 1)
		(1  76   76 genPushReceiverBytecode needsFrameNever: 1)
		(1  77   77 genExtPushPseudoVariableOrOuterBytecode needsFrameIfExtBGT2: 1)
		(1  78   78 genPushConstantZeroBytecode needsFrameNever: 1)
		(1  79   79 genPushConstantOneBytecode needsFrameNever: 1)

		(1   80   80 genSpecialSelectorArithmetic isMapped AddRR)
		(1   81   81 genSpecialSelectorArithmetic isMapped SubRR)
		(1   82   82 genSpecialSelectorComparison isMapped JumpLess)
		(1   83   83 genSpecialSelectorComparison isMapped JumpGreater)
		(1   84   84 genSpecialSelectorComparison isMapped JumpLessOrEqual)
		(1   85   85 genSpecialSelectorComparison isMapped JumpGreaterOrEqual)
		(1   86   86 genSpecialSelectorComparison isMapped JumpZero)
		(1   87   87 genSpecialSelectorComparison isMapped JumpNonZero)
		(1   88   93 genSpecialSelectorSend isMapped)	 " #* #/ #\\ #@ #bitShift: //"
		(1   94   94 genSpecialSelectorArithmetic isMapped AndRR)
		(1   95   95 genSpecialSelectorArithmetic isMapped OrRR)
		(1   96 101 genSpecialSelectorSend isMapped) "#at: #at:put: #size #next #nextPut: #atEnd"
		(1 102 102 genSpecialSelectorEqualsEquals needsFrameNever: notMapped -1) "not mapped because it is directly inlined (for now)"
		(1 103 103 genSpecialSelectorClass needsFrameIfStackGreaterThanOne: notMapped 0) "not mapped because it is directly inlined (for now)"
		(1 104 111 genSpecialSelectorSend isMapped) "#blockCopy: #value #value: #do: #new #new: #x #y"

		(1 112 127 genSendLiteralSelector0ArgsBytecode isMapped)
		(1 128 143 genSendLiteralSelector1ArgBytecode isMapped)
		(1 144 159 genSendLiteralSelector2ArgsBytecode isMapped)
		(1 160 175	genSendAbsentImplicit0ArgsBytecode isMapped hasIRC)
			
		(1 176 183 genStoreAndPopReceiverVariableBytecode isInstVarRef is1ByteInstVarStore isMappedIfImmutability needsFrameIfImmutability: -1)
			
		(1 184 191 genStoreAndPopTemporaryVariableBytecode)

		(1 192 199 genShortUnconditionalJump	branch v3:ShortForward:Branch:Distance:)
		(1 200 207 genShortJumpIfTrue			branch isBranchTrue isMapped "because of mustBeBoolean"
													v3:ShortForward:Branch:Distance:)
		(1 208 215 genShortJumpIfFalse			branch isBranchFalse isMapped "because of mustBeBoolean"
													v3:ShortForward:Branch:Distance:)

		(1 216 216 genReturnReceiver				return needsFrameIfInBlock: isMappedInBlock 0)
		(1 217 217 genReturnTopFromMethod		return needsFrameIfInBlock: isMappedInBlock -1)
		(1 218 218 genExtReturnTopFromBlock	return needsFrameNever: -1)

		(1 219 219 duplicateTopBytecode			needsFrameNever: 1)
		(1 220 220 genPopStackBytecode			needsFrameNever: -1)
		(1 221 221 genExtNopBytecode			needsFrameNever: 0)
		(1 222 223	unknownBytecode)

		"2 byte bytecodes"
		(2 224 224 extABytecode extension					needsFrameNever: 0)
		(2 225 225 extBBytecode extension					needsFrameNever: 0)
		(2 226 226 genExtPushReceiverVariableBytecode isInstVarRef)
		(2 227 227 genExtPushLiteralVariableBytecode		needsFrameNever: 1)
		(2 228 228 genExtPushLiteralBytecode					needsFrameNever: 1)
		(2 229 229 genExtPushIntegerBytecode				needsFrameNever: 1)
		(2 230 230 genLongPushTemporaryVariableBytecode)
		(2 231 231 genPushNewArrayBytecode)
		(2 232 232 genExtStoreReceiverVariableBytecode isInstVarRef isMappedIfImmutability)
		(2 233 233 genExtStoreLiteralVariableBytecode isMappedIfImmutability)
		(2 234 234 genLongStoreTemporaryVariableBytecode)
		(2 235 235 genExtStoreAndPopReceiverVariableBytecode isInstVarRef isMappedIfImmutability)
		(2 236 236 genExtStoreAndPopLiteralVariableBytecode isMappedIfImmutability)
		(2 237 237 genLongStoreAndPopTemporaryVariableBytecode)

		(2 238 238 genExtSendBytecode isMapped)
		(2 239 239 genExtSendSuperBytecode isMapped)
		(2 240 240 genExtSendAbsentImplicitBytecode isMapped hasIRC)
		(2 241 241 genExtSendAbsentDynamicSuperBytecode isMapped hasIRC)

		(2 242 242 genExtUnconditionalJump	branch isMapped "because of interrupt check" v4:Long:Branch:Distance:)
		(2 243 243 genExtJumpIfTrue			branch isBranchTrue isMapped "because of mustBeBoolean" v4:Long:Branch:Distance:)
		(2 244 244 genExtJumpIfFalse			branch isBranchFalse isMapped "because of mustBeBoolean" v4:Long:Branch:Distance:)

		(2 245 245	genExtSendAbsentSelfBytecode isMapped hasIRC)

		(2 246 248	unknownBytecode)

		"3 byte bytecodes"
		(3 249 249 genCallPrimitiveBytecode)
		(3 250 250 genPushRemoteTempLongBytecode)
		(3 251 251 genStoreRemoteTempLongBytecode)
		(3 252 252 genStoreAndPopRemoteTempLongBytecode)
		(3 253 253 genExtPushClosureBytecode block v4:Block:Code:Size:)
		(3 254 254	genExtSendAbsentOuterBytecode isMapped hasIRC)

		(3 255 255	unknownBytecode))