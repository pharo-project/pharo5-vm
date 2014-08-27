*MethodMassage-coverage
unusedBytecode
	"Handle unusedBytecode by replacing the bytecode with the
	 correct one found in the coverage property and continuing.
	 Continue via wait/signal since return would push a result."
	| coverage semaphore process |
	self assert: (method at: pc) = method encoderClass unusedBytecode.
	coverage := method propertyValueAt: #coverage.
	self assert: coverage notNil.
	self assert: (coverage includesKey: pc).
	semaphore := Semaphore new.
	process := Processor activeProcess.

	[method
		at: pc
		put: (coverage removeKey: pc).
	 process suspendedContext unwindTo: self.
	 process suspendedContext: self.
	 semaphore signal] fork.

	semaphore wait