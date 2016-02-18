object access
lengthOf: objOop
	"Answer the number of indexable units in the given object.
	 For a CompiledMethod, the size of the method header (in bytes) should
	 be subtracted from the result."

	<api>
	<inline: true>
	^self lengthOf: objOop format: (self formatOf: objOop)