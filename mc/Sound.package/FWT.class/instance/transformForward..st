computation
transformForward: forward
	| inData inLen outData |
	forward
	ifTrue:
		["first InData is input signal, following are intermediate approx coefficients"
		inData := samples.  inLen := nSamples.
		1 to: nLevels do:
			[:i |
			self convolveAndDec: inData dataLen: inLen
					filter: hTilde out: (transform at: 2*i-1).
			self convolveAndDec: inData dataLen: inLen
					filter: gTilde out: (transform at: 2*i).
			inData := transform at: 2*i-1.  inLen := inLen // 2]]
	ifFalse:
		[inLen := nSamples >> nLevels.
		"all but last outData are next higher intermediate approximations,
		last is final reconstruction of samples"
		nLevels to: 1 by: -1 do:
			[:i |
			outData := i = 1 ifTrue: [samples]
						ifFalse: [transform at: 2*(i-1)-1].
			self convolveAndInt: (transform at: 2*i-1) dataLen: inLen
					filter: h sumOutput: false into: outData.
			self convolveAndInt: (transform at: 2*i) dataLen: inLen
					filter: g sumOutput: true into: outData.
			inLen := inLen * 2]]
