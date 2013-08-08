class initialization
initialize
	"Callback initialize"
	[self setup] "Monticello... grrr...."
		on: Error
		do: [:ex| ]