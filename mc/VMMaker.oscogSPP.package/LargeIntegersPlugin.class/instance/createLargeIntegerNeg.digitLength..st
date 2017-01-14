util
createLargeIntegerNeg: neg digitLength: digitLength
	<inline: true>
	^self
		createLargeIntegerNeg: neg byteLength: digitLength * 4