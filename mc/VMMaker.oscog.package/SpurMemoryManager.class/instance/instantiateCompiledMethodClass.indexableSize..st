instantiation
instantiateCompiledMethodClass: classObj indexableSize: nElements
	<var: #nElements type: #usqInt>
	"Allocate an instance of a CompiledMethod class."
	^self subclassResponsibility