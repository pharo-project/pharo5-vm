computation
convolveAndDec: inData dataLen: inLen filter: filter out: outData
	"convolve the input sequence with the filter and decimate by two"
	| filtLen offset outi dotp |
	filtLen := filter size.
	outi := 1.
	1 to: inLen+9 by: 2 do:
		[:i | 
		i < filtLen
		ifTrue:
			[dotp := self dotpData: inData endIndex: i filter: filter
						start: 1 stop: i inc: 1]
		ifFalse:
			[i > (inLen+5)
			ifTrue:
				[offset := i - (inLen+5).
				dotp := self dotpData: inData endIndex: inLen+5 filter: filter
						start: 1+offset stop: filtLen inc: 1]
			ifFalse:
				[dotp := self dotpData: inData endIndex: i filter: filter
						start: 1 stop: filtLen inc: 1]].
		outData at: outi put: dotp.
		outi := outi + 1]