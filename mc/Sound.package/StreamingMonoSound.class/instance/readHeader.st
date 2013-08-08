private
readHeader
	"Read the sound file header from my stream."

	| id |
	stream position: headerStart.
	id := (stream next: 4) asString.
	stream position: headerStart.
	id = '.snd' ifTrue: [^ self readSunAudioHeader].
	id = 'FORM' ifTrue: [^ self readAIFFHeader].
	self error: 'unrecognized sound file format'.
