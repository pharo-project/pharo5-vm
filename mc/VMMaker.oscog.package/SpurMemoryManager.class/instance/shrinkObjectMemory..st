growing/shrinking memory
shrinkObjectMemory: delta
	"Attempt to shrink the object memory by the given delta amount."
	<doNotGenerate>
	segmentManager shrinkObjectMemory: delta