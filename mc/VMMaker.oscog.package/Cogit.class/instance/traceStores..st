debugging
traceStores: aBooleanOrInteger
	<doNotGenerate>
	traceStores := aBooleanOrInteger isInteger
							ifTrue: [aBooleanOrInteger]
							ifFalse: [aBooleanOrInteger ifTrue: [1] ifFalse: [0]]