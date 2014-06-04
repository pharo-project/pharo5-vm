initialize-release
initialize
	<doNotGenerate>
	awolProcLength := CogThreadManager awolProcessesIncrement.
	awolProcesses := CArrayAccessor on: (Array new: awolProcLength).
	awolProcIndex := 0