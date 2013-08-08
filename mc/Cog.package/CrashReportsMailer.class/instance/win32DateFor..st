reporting
win32DateFor: dateAndTimeString 
	"transform 'Thu Jun 24 14:11:18 2010' to 'Jun 24 2010 14:11:18' to allow parsing"
	| tokens |
	tokens := dateAndTimeString subStrings: ' '.
	^({ tokens second. tokens third. tokens fifth. tokens fourth } fold: [:a :b| a, ' ', b]) asTimeStamp