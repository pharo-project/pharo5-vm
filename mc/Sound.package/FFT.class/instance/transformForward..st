transforming
transformForward: forward
	| lev lev1 ip theta realU imagU realT imagT i |
	<primitive: 'primitiveFFTTransformData' module: 'FFTPlugin'>
	self permuteData.
	1 to: nu do:
		[:level |
		lev := 1 bitShift: level.
		lev1 := lev // 2.
		1 to: lev1 do:
			[:j |
			theta := j-1 * (n // lev).   "pi * (j-1) / lev1 mapped onto 0..n/2"
			theta < (n//4)  "Compute U, the complex multiplier for each level"
				ifTrue:
					[realU := sinTable at: sinTable size - theta.
					imagU := sinTable at: theta + 1]
				ifFalse:
					[realU := (sinTable at: theta - (n//4) + 1) negated.
					imagU := sinTable at: (n//2) - theta + 1].
			forward ifFalse: [imagU := imagU negated].
"
			Here is the inner loop...
			j to: n by: lev do:
				[:i |   hand-transformed to whileTrue...
"
			i := j.
			[i <= n] whileTrue:
				[ip := i + lev1.
				realT := ((realData at: ip) * realU) - ((imagData at: ip) * imagU).
				imagT := ((realData at: ip) * imagU) + ((imagData at: ip) * realU).
				realData at: ip put: (realData at: i) - realT.
				imagData at: ip put: (imagData at: i) - imagT.
				realData at: i put: (realData at: i) + realT.
				imagData at: i put: (imagData at: i) + imagT.
				i := i + lev]]].
	forward ifFalse: [self scaleData]  "Reverse transform must scale to be an inverse"