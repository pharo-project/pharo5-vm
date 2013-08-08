initialize-release
initialize
	<doNotGenerate>
	stringArgs := CArrayAccessor on: (Array new: ThreadedFFIPlugin maxNumArgs).
	stringArgIndex := 0.
	structReturnSize := 0