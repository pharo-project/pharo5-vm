transforming
transformForward: forward
	| lev lev1 ip theta realU imagU realT imagT i fftSize2 fftSize4 fftScale ii |
	<var: #realU type:'float '>
	<var: #realT type:'float '>
	<var: #imagU type:'float '>
	<var: #imagT type:'float '>
	fftSize2 := fftSize // 2.
	fftSize4 := fftSize // 4.
	1 to: nu do:
		[:level |
		lev := 1 << level.
		lev1 := lev // 2.
		fftScale := fftSize // lev.
		1 to: lev1 do:
			[:j |
			theta := j-1 * fftScale.   "pi * (j-1) / lev1 mapped onto 0..n/2"
			theta < fftSize4  "Compute U, the complex multiplier for each level"
				ifTrue:
					[realU := sinTable at: sinTableSize - theta - 1.
					imagU := sinTable at: theta]
				ifFalse:
					[realU := 0.0 - (sinTable at: theta - fftSize4).
					imagU := sinTable at: fftSize2 - theta].
			forward ifFalse: [imagU := 0.0 - imagU].
"
			Here is the inner loop...
			j to: n by: lev do:
				[:i |   hand-transformed to whileTrue...
"
			i := j.
			[i <= fftSize] whileTrue:
				[ip := i + lev1 - 1.
				ii := i-1.
				realT := ((realData at: ip) * realU) - ((imagData at: ip) * imagU).
				imagT := ((realData at: ip) * imagU) + ((imagData at: ip) * realU).
				realData at: ip put: (realData at: ii) - realT.
				imagData at: ip put: (imagData at: ii) - imagT.
				realData at: ii put: (realData at: ii) + realT.
				imagData at: ii put: (imagData at: ii) + imagT.
				i := i + lev]]].