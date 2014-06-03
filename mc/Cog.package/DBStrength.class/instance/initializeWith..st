private
initializeWith: symVal
	"Record my symbolic value and reset my arithmetic value."

	symbolicValue := symVal.
	arithmeticValue := StrengthTable at: symbolicValue.