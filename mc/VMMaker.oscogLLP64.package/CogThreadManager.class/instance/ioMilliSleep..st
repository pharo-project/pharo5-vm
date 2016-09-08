simulation
ioMilliSleep: milliseconds
	"Pause the calling thread/process for milliseconds.
	 See platforms/<plat>/vm/sqPlatformSpecific.h for the actual definition."
	<doNotGenerate>
	(Delay forMilliseconds: milliseconds) wait