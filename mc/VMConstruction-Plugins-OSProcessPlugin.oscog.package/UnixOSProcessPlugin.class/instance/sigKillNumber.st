private - signum
sigKillNumber
	"Kill signal"

	^self cCode: [#SIGKILL] inSmalltalk: [9]
