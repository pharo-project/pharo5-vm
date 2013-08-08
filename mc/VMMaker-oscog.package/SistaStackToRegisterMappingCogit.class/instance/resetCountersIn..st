sista callbacks
resetCountersIn: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	<api>
	self
		fillInCounters: cogMethod numCounters
		atEndAddress: cogMethod asUnsignedInteger + cogMethod blockSize