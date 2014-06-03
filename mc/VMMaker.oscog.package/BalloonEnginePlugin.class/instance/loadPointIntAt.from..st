private
loadPointIntAt: index from: intArray
	"Load the int value from the given index in intArray"
	^(self cCoerce: intArray to: 'int *') at: index