processor api
runInMemory: aMemory minimumAddress: minimumAddress readOnlyBelow: minimumWritableAddress
	"Note that minimumWritableAddress is both the minimum writeable address AND the maximum executable address"
	memory := aMemory.
	readableBase := minimumAddress.
	writableBase := minimumWritableAddress.
	exectuableBase := minimumAddress.
	readableLimit := aMemory byteSize.
	writableLimit := aMemory byteSize.
	exectuableLimit := minimumWritableAddress.
	self execute.