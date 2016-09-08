simulation
recordStateOf: file
	([file position]
			on: Error
			do: [:ex| nil]) ifNotNil:
		[:position|
		states at: file put: {position. file isBinary}]