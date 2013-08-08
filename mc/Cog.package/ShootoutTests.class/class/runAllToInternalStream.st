benchmark scripts
runAllToInternalStream
	"Transcript clear.
	 self runAllToInternalStream"
	^self runAllToInternalStreamVs: self referenceTimesForClosureInterpreter