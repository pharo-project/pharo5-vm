message sending
superclassOf: classPointer
	"Using a read barrier here simplifies the become implementation and costs very
	 little because the class index and superclass almost certainly share a cache line."
	<inline: true>
	^objectMemory followField: SuperclassIndex ofObject: classPointer