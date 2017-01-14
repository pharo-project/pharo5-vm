frame access
methodHeaderIndicatesLargeFrame: methodHeader
	<inline: true>
	^(methodHeader bitAnd: LargeContextBit) ~= 0