accessing
processes: anInt
	"The standard runner does use only a single process, but a benchmark can use that to do its own parallelism"
	numProcesses := anInt