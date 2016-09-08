allocation
minSlotsForShortening
	"Answer the minimum number of additional slots to allocate in an object to always be able to shorten it.
	 This is enough slots to allocate a minimum-sized object."
	^self allocationUnit * 2 / self bytesPerOop