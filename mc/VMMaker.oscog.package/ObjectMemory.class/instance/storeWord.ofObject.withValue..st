interpreter access
storeWord: fieldIndex ofObject: oop withValue: valueWord
	"This message is deprecated.  Use storeLong32, storeLong64 or storePointer"

	self abort