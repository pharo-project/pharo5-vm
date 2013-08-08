accessing
duration
	"Answer the duration of this sound in seconds."

	| dur |
	dur := 0.
	sounds do: [:snd | dur := dur max: snd duration].
	^ dur
