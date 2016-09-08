object format
fixedFieldsOf: objOop format: fmt length: wordLength
	| class |
	<inline: true>
	"N.B. written to fall through to fetchClassOfNonImm: et al for forwarders
	 so as to trigger an assert fail."
	(fmt >= self sixtyFourBitIndexableFormat or: [fmt = self arrayFormat]) ifTrue:
		[^0].  "indexable fields only"
	fmt < self arrayFormat ifTrue:
		[^wordLength].  "fixed fields only (zero or more)"
	class := self fetchClassOfNonImm: objOop.
	^self fixedFieldsOfClassFormat: (self formatOfClass: class)