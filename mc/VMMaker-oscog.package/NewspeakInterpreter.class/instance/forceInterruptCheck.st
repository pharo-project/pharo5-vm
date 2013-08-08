process primitive support
forceInterruptCheck
	"force an interrupt check ASAP - setting interruptCheckCounter to a large -ve number is used as a flag to skip messing with the feedback mechanism and nextPollTick resetting makes sure that ioProcess gets called as near immediately as we can manage"
	interruptCheckCounter := -1000.
	nextPollTick := 0