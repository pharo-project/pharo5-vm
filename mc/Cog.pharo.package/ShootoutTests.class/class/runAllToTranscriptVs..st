benchmark scripts
runAllToTranscriptVs: referenceTimes
	"Transcript clear.
	 self runAllToTranscriptVs: self referenceTimesForClosureInterpreter"
	"Transcript clear.
	 self runAllToTranscriptVs: self referenceTimesForSqueakVM"
	| times ratios geometricMean |
	times := Array new writeStream.
	ratios := Array new writeStream.
	(self standardSuiteTo: Transcript) do:
		[:block | | benchmark reference t |
		benchmark := (self selectorForSimpleBlock: block) copyUpTo: $:.
		reference := referenceTimes at: benchmark asSymbol.
		Smalltalk garbageCollect.
		times nextPut: (t := Time millisecondsToRun: block).
		ratios nextPut: t asFloat / reference.
		self report: block decompile printString time: t reference: reference on: Transcript].
	geometricMean := (ratios contents inject: 1 into: [:m :n| m * n]) raisedTo: 1 / ratios position.
	Transcript
		nextPutAll: 'geometric mean '; print: (geometricMean roundTo: 0.001);
		nextPutAll: '   average speedup '; print: ((geometricMean - 1 * 100) roundTo: 0.01); nextPut: $%; cr; cr; flush.
	^times contents