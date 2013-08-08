instance creation
fromWaveFileNamed: fileName
	"(SampledSound fromWaveFileNamed: 'c:\windows\media\chimes.wav') play"
	"| snd fd |
	fd := FileDirectory on:'c:\windows\media\'.
	fd fileNames do: [:n |
		(n asLowercase endsWith: '.wav')
			ifTrue: [
				snd := SampledSound fromWaveFileNamed: (fd pathName,n).
				snd play.
				SoundPlayer waitUntilDonePlaying: snd]]."

	^self fromWaveStream: (FileStream oldFileNamed: fileName)
