instantiation
instantiateClass: classObj indexableSize: nElements
	<var: #nElements type: #usqInt>
	"Allocate an instance of a variable class, excepting CompiledMethod."
	^self subclassResponsibility