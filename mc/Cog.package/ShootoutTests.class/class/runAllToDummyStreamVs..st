benchmark scripts
runAllToDummyStreamVs: referenceTimes
	"Transcript clear.
	 self runAllToDummyStreamVs: self referenceTimesForClosureInterpreter"
	"Transcript clear.
	 self runAllToDummyStreamVs: self referenceTimesForSqueakVM"
	^self runAllToDummyStreamVs: referenceTimes reportTo: Transcript