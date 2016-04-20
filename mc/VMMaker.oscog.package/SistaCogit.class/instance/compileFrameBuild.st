compile abstract instructions
compileFrameBuild
	"Override to prefetch counters, if any."
	super compileFrameBuild.
	counters ~= 0 ifTrue:
		[self PrefetchAw: counters]