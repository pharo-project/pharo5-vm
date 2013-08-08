accessing
duration
	"Answer the duration of this sound in seconds."

	"7 dec 2000 - handle compressed sounds. better way??"

	^sounds inject: 0 into: [:totalDuration :snd | totalDuration + snd asSound duration]