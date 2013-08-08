assound
reset
	"This message is the cue to start behaving like a real sound in order to be played.
	We do this by caching a decompressed version of this sound.
	See also samplesRemaining."

	cachedSound == nil ifTrue: [cachedSound := self asSound].
	cachedSound reset
