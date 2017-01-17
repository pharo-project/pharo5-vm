trampoline support
nextProfileTickAddress
	<api>
	<returnTypeC: #usqInt>
	"N.B. nextProfileTick is 64-bits"
	^self cCode: [(self addressOf: nextProfileTick) asUnsignedInteger]
		inSmalltalk:
			[VMBIGENDIAN
				ifTrue:
					[cogit simulatedReadWriteVariableAddress: #nextProfileTickLow in: self.
					 cogit simulatedReadWriteVariableAddress: #nextProfileTickHigh in: self]
				ifFalse:
					[cogit simulatedReadWriteVariableAddress: #nextProfileTickHigh in: self.
					 cogit simulatedReadWriteVariableAddress: #nextProfileTickLow in: self]]