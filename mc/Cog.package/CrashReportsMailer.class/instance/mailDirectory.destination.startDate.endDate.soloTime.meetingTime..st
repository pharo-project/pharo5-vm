initialize-release
mailDirectory: aFileDirectoryOrString destination: anEmailAddress startDate: startTimestamp endDate: endTimestamp soloTime: soloDuration meetingTime: meetingDuration
	mailDirectory := aFileDirectoryOrString isString
						ifTrue: [FileDirectory on: aFileDirectoryOrString]
						ifFalse: [aFileDirectoryOrString].
	destination := anEmailAddress.
	startDate := startTimestamp.
	endDate := endTimestamp.
	soloTime := soloDuration.
	meetingTime := meetingDuration.
	rs := ReadWriteStream on: (String new: 256)