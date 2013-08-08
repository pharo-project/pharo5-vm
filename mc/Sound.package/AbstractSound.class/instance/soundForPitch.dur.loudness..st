initialization
soundForPitch: pitchNameOrNumber dur: d loudness: l
	"Answer an initialized sound object (a copy of the receiver) that generates a note of the given pitch, duration, and loudness. Pitch may be a numeric pitch or a string pitch name such as 'c4'. Duration is in seconds and loudness is in the range 0.0 to 1.0."

	^ self copy setPitch: pitchNameOrNumber dur: d loudness: l
