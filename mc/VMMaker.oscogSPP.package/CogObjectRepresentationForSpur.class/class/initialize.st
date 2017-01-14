class initialization
initialize
	"Number of trampolines for the combined IMMUTABILITY/store check instance variable store.
	 Trampolines from 0 to NumStoreTrampolines - 2 are dedicated to an inst var index, the last one is generic."
	NumStoreTrampolines := 5