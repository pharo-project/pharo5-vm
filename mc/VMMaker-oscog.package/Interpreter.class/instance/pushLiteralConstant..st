stack bytecodes
pushLiteralConstant: literalIndex

	self internalPush: (self literal: literalIndex).