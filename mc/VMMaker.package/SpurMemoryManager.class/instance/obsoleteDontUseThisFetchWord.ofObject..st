plugin support
obsoleteDontUseThisFetchWord: fieldIndex ofObject: oop
	"This message is deprecated but supported for a while via a tweak to sqVirtualMachine.[ch] Use fetchLong32, fetchLong64 or fetchPointer instead for new code"
	<api>
	^self fetchLong32: fieldIndex ofObject: oop