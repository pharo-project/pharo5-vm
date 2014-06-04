arithmetic integer primitives
primitiveSubtract

	self pop2AndPushIntegerIfOK: (self stackIntegerValue: 1) - (self stackIntegerValue: 0)