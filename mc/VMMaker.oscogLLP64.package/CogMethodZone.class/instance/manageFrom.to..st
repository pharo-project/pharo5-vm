initialization
manageFrom: theStartAddress to: theLimitAddress
	<returnTypeC: #void>
	mzFreeStart := baseAddress := theStartAddress.
	youngReferrers := limitAddress := theLimitAddress.
	openPICList := nil.
	NewspeakVM ifTrue: [unpairedMethodList := nil].
	methodBytesFreedSinceLastCompaction := 0.
	methodCount := 0