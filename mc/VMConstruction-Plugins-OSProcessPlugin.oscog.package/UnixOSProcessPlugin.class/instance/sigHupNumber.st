private - signum
sigHupNumber
	"Hangup detected on controlling terminal or death of controlling process"

	^self cCode: [#SIGHUP] inSmalltalk: [1]
