object format
nonWeakFieldsOf: oop
	"Return the number of non-weak fields in oop (i.e. the number of fixed fields).
	Note: The following is copied from fixedFieldsOf:format:length: since we do know
	the format of the oop (e.g. format = 4) and thus don't need the length."
	| class classFormat |
	<inline: false> "No need to inline - we won't call this often"

	self assert: (self isWeakNonInt: oop).

	"fmt = 3 or 4: mixture of fixed and indexable fields, so must look at class format word"
	class := self fetchClassOfNonInt: oop.
	classFormat := self formatOfClass: class.
	^(classFormat >> 11 bitAnd: 16rC0) + (classFormat >> 2 bitAnd: 16r3F) - 1