instance creation
buildSmallOrchestra
	"Example of how to build a skeleton orchestra that uses less memory (about 14 MBytes)."
	"SampledInstrument buildSmallOrchestra"

	| dir |
	AbstractSound unloadSampledTimbres.
	dir := 'Tosh:Not Backed Up:Sample Library:Orchestra'.
	#(clarinet oboe bassoon trombone tympani) do: [:instName |
		SampledInstrument
			readSimpleInstrument: instName
			fromDirectory: dir.
		(AbstractSound soundNamed: instName, '-f') pruneToNotesPerOctave: 1].
	#(flute bass) do: [:instName |
		SampledInstrument
			readSimpleInstrument: instName
			fromDirectory: dir.
		(AbstractSound soundNamed: instName, '-f') pruneToNotesPerOctave: 2].

	(AbstractSound soundNamed: 'bass-f') allNotes do: [:n |
		n firstSample: (n findStartPointForThreshold: 2500)].

	(AbstractSound soundNamed: 'bassoon-f') allNotes do: [:n |
		n beUnlooped.
		n firstSample: (n findStartPointForThreshold: 0)].

	(AbstractSound soundNamed: 'trombone-f') allNotes do: [:n |
		n firstSample: (n findStartPointForThreshold: 1800)].

	AbstractSound soundNamed: 'trumpet-f' put: (AbstractSound soundNamed: 'trombone-f').
	AbstractSound soundNamed: 'horn-f' put: (AbstractSound soundNamed: 'trombone-f').
	AbstractSound soundNamed: 'violin-f' put: (AbstractSound soundNamed: 'bass-f').
	AbstractSound soundNamed: 'viola-f' put: (AbstractSound soundNamed: 'bass-f').
	AbstractSound soundNamed: 'cello-f' put: (AbstractSound soundNamed: 'bass-f').

	(AbstractSound soundNamed: 'bassoon-f') allNotes do: [:n | n beUnlooped].

