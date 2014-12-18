object access
fetchLong32: fieldIndex ofFloatObject: oop
	"index by word size, and return a pointer as long as the word size"
	<inline: true>
	^self fetchLong32: fieldIndex ofObject: oop