instance creation
readSimpleInstrument: instName fromDirectory: orchestraDir
	"SampledInstrument
		readSimpleInstrument: 'oboe'
		fromDirectory: 'Tosh:Sample Library:Orchestra'"

	| sampleSetDir memBefore memAfter sampleSet snd |
	sampleSetDir := orchestraDir, ':', instName, ' f'.
	memBefore := Smalltalk garbageCollect.
	sampleSet := SampledInstrument new readSampleSetFrom: sampleSetDir.
	memAfter := Smalltalk garbageCollect.
	Transcript show:
		instName, ': ', (memBefore - memAfter) printString,
		' bytes; ', memAfter printString, ' bytes left'; cr.
	AbstractSound soundNamed: instName, '-f' put:
		(snd := SampledInstrument new allSampleSets: sampleSet).

	"fix slow attacks"
	snd allNotes do: [:n |
		n firstSample: (n findStartPointForThreshold: 1000)].

	^ snd
