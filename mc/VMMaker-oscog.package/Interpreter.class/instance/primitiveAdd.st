arithmetic integer primitives
primitiveAdd

	self pop2AndPushIntegerIfOK: (self stackIntegerValue: 1) + (self stackIntegerValue: 0)