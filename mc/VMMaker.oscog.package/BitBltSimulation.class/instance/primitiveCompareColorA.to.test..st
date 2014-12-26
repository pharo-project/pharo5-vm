primitives
primitiveCompareColorA: colorA to: colorB test: testID 
	"Invoke the pixel color comparing primitive.Only applicable if compiling
	with ENABLE_FAST_BLT"
	| rcvr val |
	<export: true>
	rcvr := self
				primitive: 'primitiveCompareColors'
				parameters: #(#Unsigned #Unsigned #SmallInteger )
				receiver: #Oop.
	self
		cppIf: #'ENABLE_FAST_BLT'
		ifTrue: [(self loadBitBltFrom: rcvr)
					ifFalse: [^ interpreterProxy primitiveFail].
			self clipRange.
			(bbW <= 0 or: [bbH <= 0])
				ifTrue: ["zero width or height; noop"
					^ interpreterProxy primitiveFail].
			self cCode: '
	compare_operation_t op;
	op.matchRule = testID & 3;
	op.tally = testID & (1u<<3);
	op.srcA.bits = (void *) sourceBits;
	op.srcA.pitch = sourcePitch;
	op.srcA.depth = sourceDepth;
	op.srcA.msb = sourceMSB;
	op.srcA.x = sx;
	op.srcA.y = sy;
	op.srcB.bits = (void *) destBits;
	op.srcB.pitch = destPitch;
	op.srcB.depth = destDepth;
	op.srcB.msb = destMSB;
	op.srcB.x = dx;
	op.srcB.y = dy;
	op.width = bbW;
	op.height = bbH;
	op.colorA = colorA;
	op.colorB = colorB;

	val = compareColorsDispatch(&op);'.
	^val asPositiveIntegerObj]
		ifFalse: [interpreterProxy primitiveFail]