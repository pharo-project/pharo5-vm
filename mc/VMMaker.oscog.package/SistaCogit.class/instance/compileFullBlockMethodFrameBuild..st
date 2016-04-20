compile abstract instructions
compileFullBlockMethodFrameBuild: numCopied
	"Override to prefetch counters if any"
	super compileFullBlockMethodFrameBuild: numCopied.
	counters ~= 0 ifTrue:
		[self PrefetchAw: counters]