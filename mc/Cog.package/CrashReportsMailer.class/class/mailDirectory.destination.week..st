instance creation
mailDirectory: aFileDirectoryOrString destination: anEmailAddress week: startDate
	^self new
		mailDirectory: aFileDirectoryOrString
		destination: anEmailAddress
		startDate: (TimeStamp fromSeconds: startDate asDate asSeconds)
		endDate:  (TimeStamp fromSeconds: (startDate asDate addDays: 7) asSeconds)

	"(self mailDirectory: '/Users/eliot/Library/Mail/IMAP-emiranda@ussc9-mail01.qwaq.com/INBOX.imapmbox/Messages'
		destination: 'eng@teleplace.com'
		week: '05/15/2010') generateReport"