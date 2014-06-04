compiled methods
alternateHeaderHasPrimitiveFlag: methodHeader
	<inline: true>
	^methodHeader anyMask: 16r10000 << SmallIntegerShift