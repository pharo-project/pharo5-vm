parsing
ifCrashReport: fileName do: aBlock
	"Answer the evaluation of aBlock with the lines for fileName if it is a crash report, or nil if not."
	| file lines subject |
	file := mailDirectory oldFileNamed: fileName.
	lines := [file contentsOfEntireFile]
				on: Error
				do: [:ex|
					file close.
					Transcript nextPutAll: fileName; nextPutAll: ': '; nextPutAll: ex messageText; flush.
					^nil].
	lines := self breakIntoLines: lines.
	subject := lines detect: [:l| l beginsWith: 'Subject:'] ifNone: [^nil].
	(subject includesSubString: 'Teleplace Bug Report: ') ifFalse: [^nil].
	#('@qwaq.com' '@teleplace.com' '@chonkaa.com' 'craig@netjam.org' 'skysound@mac.com') do:
		[:localEmail| (subject includesSubstring: localEmail caseSensitive: false) ifTrue: [^nil]].
	(lines anySatisfy:
		[:l|
		((l beginsWith: 'OS Version') and: [l includesSubString: 'Mac OS X'])
		or: [l beginsWith: 'Operating System:']]) ifFalse: [^nil].
	^aBlock value: lines