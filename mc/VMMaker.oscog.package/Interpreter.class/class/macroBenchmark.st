benchmarks
macroBenchmark  "Interpreter macroBenchmark"
	"Copied from Interpreter class>>translate:doInlining:forBrowserPlugin:"
	| cg fileName |
	fileName := 'benchmark2.out'.
	Interpreter initialize.
	ObjectMemory initialize.
	cg := CCodeGenerator new initialize.
	Interpreter initialize.
	ObjectMemory initializeWithOptions: (Dictionary new
											at: #BytesPerWord put: 4;
											yourself).
	cg addClass: Interpreter.
	cg addClass: ObjectMemory.
	Interpreter declareCVarsIn: cg.
	ObjectMemory declareCVarsIn: cg.
	FileDirectory default deleteFileNamed: fileName.
	cg storeCodeOnFile: fileName doInlining: true.
	FileDirectory default deleteFileNamed: fileName.