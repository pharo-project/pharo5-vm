running
makeTestData: fileName using: aBlock seed: seed rounds: rounds
	| bytes out float result |
	bytes := ByteArray new: 8.
	out := FileStream newFileNamed: fileName.
	[
		out binary. 
		out nextNumber: 4 put: rounds.
		out nextNumber: 4 put: seed.
		random := Random seed: seed.
		float := Float basicNew: 2.
		'Creating test data for: ', fileName 
			displayProgressAt: Sensor cursorPoint 
			from: 1 to: rounds during:[:bar|
				1 to: rounds do:[:i|
					i \\ 10000 = 0 ifTrue:[bar value: i].
					[1 to: 8 do:[:j| bytes at: j put: (random nextInt: 256)-1].
					float basicAt: 1 put: (bytes unsignedLongAt: 1 bigEndian: true).
					float basicAt: 2 put: (bytes unsignedLongAt: 5 bigEndian: true).
					float isNaN] whileTrue.
					result := aBlock value: float.
					out nextNumber: 4 put: (result basicAt: 1).
					out nextNumber: 4 put: (result basicAt: 2).
				].
			].
	] ensure:[out close].
