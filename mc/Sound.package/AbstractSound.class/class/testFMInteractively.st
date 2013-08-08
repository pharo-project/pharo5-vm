examples
testFMInteractively
	"Experiment with different settings of the FM modulation and multiplier settings interactively by moving the mouse. The top-left corner of the screen is 0 for both parameters. Stop when the mouse is pressed."
	"AbstractSound testFMInteractively"

	| s mousePt lastVal status mod ratio |
	SoundPlayer startPlayerProcessBufferSize: 1100 rate: 11025 stereo: false.
	s := FMSound pitch: 440.0 dur: 200.0 loudness: 0.2.

	SoundPlayer playSound: s.
	lastVal := nil.
	[Sensor anyButtonPressed] whileFalse: [
		mousePt := Sensor cursorPoint.
		mousePt ~= lastVal ifTrue: [
			mod := mousePt x asFloat / 20.0.
			ratio := mousePt y asFloat / 20.0.
			s modulation: mod ratio: ratio.
			lastVal := mousePt.
			status :=
'mod: ', mod printString, '
ratio: ', ratio printString.
			status displayOn: Display at: 10@10]].

	SoundPlayer shutDown.
