object format
fixedFieldsOf: objOop format: fmt length: wordLength
	| class |
	<inline: true>
	<asmLabel: false>
	(fmt > self lastPointerFormat or: [fmt = 2]) ifTrue: [^0].  "indexable fields only"
	fmt < 2 ifTrue: [^wordLength].  "fixed fields only (zero or more)"
	class := self fetchClassOfNonImm: objOop.
	^self fixedFieldsOfClassFormat: (self formatOfClass: class)