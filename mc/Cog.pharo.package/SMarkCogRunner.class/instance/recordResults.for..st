initialization
recordResults: timer for: aSelector
	"Only record the results when we are not in warmup mode."
	warmingUp ifFalse: [
		super recordResults: timer for: aSelector.
	].