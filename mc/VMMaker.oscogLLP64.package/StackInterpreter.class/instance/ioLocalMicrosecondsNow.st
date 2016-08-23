primitive support
ioLocalMicrosecondsNow
	<doNotGenerate>
	^self ioUTCMicrosecondsNow + (1000000 * DateAndTime localOffset asSeconds)