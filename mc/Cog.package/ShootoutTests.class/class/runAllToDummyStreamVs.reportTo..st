benchmark scripts
runAllToDummyStreamVs: referenceTimes reportTo: aStream
	"Transcript clear.
	 self runAllToDummyStreamVs: self referenceTimesForClosureInterpreter"
	"Transcript clear.
	 self runAllToDummyStreamVs: self referenceTimesForSqueakVM"
	| times ratios geometricMean |
	times := Array new writeStream.
	ratios := Array new writeStream.
	(self standardSuiteTo: DummyStream basicNew) do:
		[:block | | benchmark reference t |
		benchmark := (self selectorForSimpleBlock: block) copyUpTo: $:.
		reference := referenceTimes at: benchmark asSymbol.
		Smalltalk garbageCollect.
		times nextPut: (t := Time millisecondsToRun: block).
		ratios nextPut: t asFloat / reference.
		self report: block decompile printString time: t reference: reference on: aStream].
	geometricMean := (ratios contents inject: 1 into: [:m :n| m * n]) raisedTo: 1 / ratios position.
	aStream
		nextPutAll: 'geometric mean '; print: (geometricMean roundTo: 0.001);
		nextPutAll: '   average speedup '; print: ((geometricMean - 1 * 100) roundTo: 0.01); nextPut: $%; cr; cr; flush.
	^times contents