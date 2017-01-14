accessing
imageNameForTests
	"self imageNameForTests"
	| baseImageName |
	baseImageName := 'core32-preen.image'.
	#('.' 'oscogvm/image' '../oscogvm/image') do:
		[:dirName|
		 ((FileDirectory default directoryExists: dirName)
		  and: [(FileDirectory on: dirName) fileExists: baseImageName]) ifTrue:
			[^dirName, '/', baseImageName]].
	self error: 'cannot find ', baseImageName