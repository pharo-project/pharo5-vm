instance creation
readLoudAndStaccatoInstrument: instName fromDirectory: orchestraDir
	"SampledInstrument
		readLoudAndStaccatoInstrument: 'oboe'
		fromDirectory: 'Tosh:Sample Library:Orchestra'"

	| sampleSetDir memBefore memAfter loud short snd |
	sampleSetDir := orchestraDir, ':', instName.
	memBefore := Smalltalk garbageCollect.
	loud := SampledInstrument new readSampleSetFrom: sampleSetDir, ' f'.
	short := SampledInstrument new readSampleSetFrom: sampleSetDir, ' stacc'.
	memAfter := Smalltalk garbageCollect.
	Transcript show:
		instName, ': ', (memBefore - memAfter) printString,
		' bytes; ', memAfter printString, ' bytes left'; cr.
	AbstractSound soundNamed: instName, '-f&stacc' put:
		(snd := SampledInstrument new
			allSampleSets: loud;
			staccatoLoudAndSoftSampleSet: short).
	"fix slow attacks"
	snd allNotes do: [:n | n firstSample: (n findStartPointForThreshold: 500)].

	AbstractSound soundNamed: instName, '-f' put:
		(snd := SampledInstrument new
			allSampleSets: loud).
	"fix slow attacks"
	snd allNotes do: [:n | n firstSample: (n findStartPointForThreshold: 1000)].
