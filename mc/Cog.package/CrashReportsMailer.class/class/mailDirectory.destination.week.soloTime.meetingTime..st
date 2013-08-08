instance creation
mailDirectory: aFileDirectoryOrString destination: anEmailAddress week: startDateString soloTime: soloDurationOrString meetingTime: meetingDurationOrString
	| startDate |
	startDate := ((startDateString includes: $-)
					ifTrue: [(#(2 3 1) collect: [:i| (startDateString subStrings: '-') at: i]) fold: [:a :b| a,'/',b]]
					ifFalse: [startDateString]) asDate.
	^self new
		mailDirectory: aFileDirectoryOrString
		destination: anEmailAddress
		startDate: (TimeStamp fromSeconds: startDate asSeconds)
		endDate:  (TimeStamp fromSeconds: (startDate addDays: 7) asSeconds - 1)
		soloTime: soloDurationOrString asDuration
		meetingTime: meetingDurationOrString asDuration

	"(self mailDirectory: '/Users/eliot/Library/Mail/IMAP-emiranda@ussc9-mail01.qwaq.com/INBOX.imapmbox/Messages'
		destination: 'eng@teleplace.com'
		week: '05/15/2010'
		soloTime: '20:19:38:55'
		meetingTime: '7:23:44:45') generateReport"