simulation
shortRunValueAt: index from: runArray
	"Load the short value from the given index in intArray"

	^ (interpreterProxy halfWordLowInLong32: (runArray at: index)) signedIntFromShort 