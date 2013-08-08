parsing
candidateMessagesDo: aBlock
	"Evaluate aBlock with the file names of every file newer than the start date minus some slop"
	| start |
	start := (startDate minusDays: 7) asSeconds.
	mailDirectory entries do:
		[:dirEntry|
		((dirEntry name endsWith: '.emlx')
		 and: [dirEntry creationTime > start]) ifTrue:
			[aBlock value: dirEntry name]]