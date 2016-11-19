simulation
memoryClass
	"Answer the class to use for the memory inst var in simulation.
	 Answer nil if a suitable class isn't available.  This version uses a 64-bit element class if available."
	<doNotGenerate>
	^Smalltalk classNamed: #DoubleWordArray