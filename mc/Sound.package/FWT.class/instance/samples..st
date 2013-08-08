access
samples: anArray
	1 to: anArray size do:
		[:i | samples at: i put: (anArray at: i)].
	nSamples+1 to: nSamples+5 do:
		[:i | samples at: i put: 0.0]