system startup
startUp: resuming
	resuming ifTrue:
		[SavedState keysAndValuesDo:
			[:processorOrNil :state|
			 processorOrNil ifNotNil:
				[processorOrNil addressFieldPut: processorOrNil class primitiveNewCPU.
				 state with: processorOrNil registerStateSetters do:
					[:value :setter|
					processorOrNil perform: setter with: value]]]].
	SavedState removeAll