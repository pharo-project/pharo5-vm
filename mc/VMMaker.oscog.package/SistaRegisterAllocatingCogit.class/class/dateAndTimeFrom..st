clone maintennance
dateAndTimeFrom: timeStampString
	^(timeStampString copyFrom: (timeStampString findFirst: [:c| c isDigit]) to: timeStampString size) asDateAndTime