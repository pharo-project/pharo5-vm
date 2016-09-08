decoding
scaleAndSignExtend: aNumber inFieldWidth: w
	<inline: true>
	aNumber < (1 << (w - 1))
		ifTrue: [^aNumber - (1 << w) + 1]
		ifFalse: [^aNumber]