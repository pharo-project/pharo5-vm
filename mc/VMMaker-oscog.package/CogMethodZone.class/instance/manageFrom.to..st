initialization
manageFrom: theStartAddress to: theLimitAddress
	<returnTypeC: #void>
	mzFreeStart := baseAddress := theStartAddress.
	youngReferrers := limitAddress := theLimitAddress.
	openPICList := nil.
	methodBytesFreedSinceLastCompaction := 0.
	methodCount := 0