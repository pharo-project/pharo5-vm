playing
playAndWaitUntilDone
	"Play this sound to the sound ouput port and wait until it has finished playing before returning."

	SoundPlayer playSound: self.
	[self samplesRemaining > 0] whileTrue.
	(Delay forMilliseconds: 2 * SoundPlayer bufferMSecs) wait.  "ensure last buffer has been output"
