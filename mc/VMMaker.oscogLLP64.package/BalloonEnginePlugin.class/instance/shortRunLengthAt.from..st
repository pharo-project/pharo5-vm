private
shortRunLengthAt: i from: runArray
	"Return the run-length value from the given ShortRunArray."
	^((self cCoerce: runArray to:'int *') at: i) bitShift: -16