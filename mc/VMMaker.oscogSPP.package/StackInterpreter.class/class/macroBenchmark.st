benchmarks
macroBenchmark  "StackInterpreter macroBenchmark"
	| dir |
	dir := 'benchmark2.dir'.
	(FileDirectory default directoryExists: dir)
		ifTrue: [(FileDirectory default directoryNamed: dir) recursiveDeleteContents]
		ifFalse: [(FileDirectory default directoryNamed: dir) assureExistence].
	([VMMaker
			makerFor: StackInterpreter
			and: nil
			with: #()
			to: (FileDirectory default pathFromURI: dir)
			platformDir: 'none'
			excluding:  (InterpreterPlugin withAllSubclasses collect: [:ea| ea name])]
		on: VMMakerException "suppress bleats about non-existent platforms dir"
		do: [:ex| ex resume: nil])
			generateInterpreterFile.
	(FileDirectory default directoryNamed: dir) recursiveDeleteContents; recursiveDelete