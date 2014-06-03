simulation
initializeProcessorForThreadIndex: threadIndex
	"Each simulated processor thread gets 4k of the rump C stack."
	<doNotGenerate>
	cogit initializeProcessorStack: (self cStackRangeForThreadIndex: threadIndex) last