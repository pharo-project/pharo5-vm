initialization
initializeCounters
	"Initialize the counter labels for the current compilation.  We give them bogus
	 addresses since we can't determine their address until after the map is generated.
	 So we have to regenerate their dependent instructions after map generation."
	self reinitializeCountersFrom: 0 to: numCounters - 1.
	counterIndex := 0