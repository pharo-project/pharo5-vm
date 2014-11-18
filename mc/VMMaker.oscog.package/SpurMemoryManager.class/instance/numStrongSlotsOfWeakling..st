object access
numStrongSlotsOfWeakling: objOop
	"Answer the number of strong pointer fields in the given weakling."
	<api>
	<inline: true>
	self assert: (self formatOf: objOop) = self weakArrayFormat.
	^self fixedFieldsOfClass: (self fetchClassOfNonImm: objOop)