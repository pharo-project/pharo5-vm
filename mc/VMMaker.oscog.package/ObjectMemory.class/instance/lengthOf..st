object access
lengthOf: oop
	"Return the number of indexable bytes or words in the given object. Assume the argument is not an integer. For a CompiledMethod, the size of the method header (in bytes) should be subtracted from the result."

	<api>
	| header |
	<inline: true>
	header := self baseHeader: oop.
	^self lengthOf: oop baseHeader: header format: (self formatOfHeader: header)