simulation stack
ssPopNativeSize: popSize
	<option: #LowcodeVM>
	| poppingSize stackPosition popCount |
	poppingSize := 0.
	stackPosition := simNativeStackPtr.
	[ poppingSize < popSize and: [ stackPosition >= 0 ] ] whileTrue: [
		poppingSize := poppingSize + (self simNativeStackAt: stackPosition) stackSpillSize.
		stackPosition := stackPosition - 1
	].

	self assert: poppingSize = popSize.
	popCount := simNativeStackPtr - stackPosition.
	self ssNativePop: popCount.