primitive support
ioLocalMicroseconds
	<doNotGenerate>
	^self ioUTCMicroseconds + (1000000 * DateAndTime localOffset asSeconds)