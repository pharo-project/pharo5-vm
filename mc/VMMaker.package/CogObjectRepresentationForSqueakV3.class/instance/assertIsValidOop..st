garbage collection
assertIsValidOop: anOop
	<doNotGenerate>
	"Method map assertion chekcing only (development time only).
	 Note we never put SmallIntegers in the map."
	^objectMemory addressCouldBeObj: anOop