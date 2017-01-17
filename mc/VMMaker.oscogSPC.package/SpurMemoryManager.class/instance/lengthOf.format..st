object access
lengthOf: objOop format: fmt
	"Answer the number of indexable units in the given object.
	 For a CompiledMethod, the size of the method header (in bytes)
	 should be subtracted from the result of this method."
	^self subclassResponsibility