utilities
removeVariable: aName
	"Remove the given (instance) variable from the code base."
	self removeVariable: aName
		ifAbsent:
			[(vmClass notNil
			  and: [vmClass isNonArgumentImplicitReceiverVariableName: aName]) ifFalse:
				[logger
					ensureCr;
					show: 'warning, variable '
						, aName
						, ' doesn''t exist or has already been removed';
						cr]]