class initialization
initializeWithOptions: optionsDictionary

	super initializeWithOptions: optionsDictionary.
	CounterBytes := 4.
	MaxCounterValue := (1 << 16) - 1