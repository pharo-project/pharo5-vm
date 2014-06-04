benchmarks
macroBenchmark
	"StackInterpreter macroBenchmark"

	| dir |
	dir := 'benchmark2.dir' asFileReference.
	dir isDirectory
		ifTrue: [ dir deleteAllChildren ]
		ifFalse: [ dir ensureCreateDirectory ].
	([ 
	VMMaker
		makerFor: StackInterpreter
		and: nil
		with: #()
		to: dir asFileReference fullName
		platformDir: 'none'
		excluding: (InterpreterPlugin withAllSubclasses collect: [ :ea | ea name ]) ]
		on: VMMakerException
		do: [ :ex | ex resume: nil ]) generateInterpreterFile.	"suppress bleats about non-existent platforms dir"
	dir
		deleteAllChildren;
		recursiveDelete