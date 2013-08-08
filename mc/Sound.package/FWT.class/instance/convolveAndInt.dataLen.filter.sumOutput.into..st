computation
convolveAndInt: inData dataLen: inLen filter: filter sumOutput:
sumOutput into: outData
	"insert zeros between each element of the input sequence and
	   convolve with the filter to interpolate the data"
	| outi filtLen oddTerm evenTerm j |
	outi := 1.
	filtLen := filter size.

	"every other dot product interpolates the data"
	filtLen // 2 to: inLen + filtLen - 2 do:
		[:i |
		oddTerm := self dotpData: inData endIndex: i filter: filter
									start: 2 stop: filter size inc: 2.
		evenTerm := self dotpData: inData endIndex: i+1 filter: filter
									start: 1 stop: filter size inc: 2.
		sumOutput
			ifTrue:
				["summation with previous convolution if true"
				outData at: outi put: (outData at: outi) + oddTerm.
				outData at: outi+1 put: (outData at: outi+1) + evenTerm]
			ifFalse:
				["first convolution of pair if false"
				outData at: outi put: oddTerm.
				outData at: outi+1 put: evenTerm].
		outi := outi + 2].

	"Ought to be able to fit this last term into the above loop."
	j := inLen + filtLen - 1.
	oddTerm := self dotpData: inData endIndex: j filter: filter
									start: 2 stop: filter size inc: 2.
	sumOutput
		ifTrue: [outData at: outi put: (outData at: outi) + oddTerm]
		ifFalse: [outData at: outi put: oddTerm].
