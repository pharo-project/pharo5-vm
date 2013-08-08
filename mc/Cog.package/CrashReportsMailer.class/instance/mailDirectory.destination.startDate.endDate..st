initialize-release
mailDirectory: aFileDirectoryOrString destination: anEmailAddress startDate: startTimestamp endDate: endTimestamp
	mailDirectory := aFileDirectoryOrString isString
						ifTrue: [FileDirectory on: aFileDirectoryOrString]
						ifFalse: [aFileDirectoryOrString].
	destination := anEmailAddress.
	startDate := startTimestamp.
	endDate := endTimestamp.
	rs := ReadWriteStream on: (String new: 256)