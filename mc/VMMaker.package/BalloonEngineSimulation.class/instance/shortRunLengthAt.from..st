simulation
shortRunLengthAt: index from: runArray
	"Load the short value from the given index in intArray"

	^ interpreterProxy halfWordHighInLong32: (runArray at: index)