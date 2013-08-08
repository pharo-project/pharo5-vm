instance creation
fromArray: anArray
	"Return a new SoundBuffer whose contents are copied from the given Array or ByteArray."

	| new |
	new := SoundBuffer newMonoSampleCount: anArray size.
	1 to: anArray size do: [:i | new at: i put: (anArray at: i)].
	^ new
