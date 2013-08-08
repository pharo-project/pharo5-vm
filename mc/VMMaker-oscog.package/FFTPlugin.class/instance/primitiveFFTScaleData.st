primitives
primitiveFFTScaleData
	| rcvr |
	<export: true>
	rcvr := interpreterProxy stackObjectValue: 0.
	(self loadFFTFrom: rcvr) ifFalse:[^nil].
	self scaleData.