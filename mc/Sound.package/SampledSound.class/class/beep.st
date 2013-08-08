instance creation
beep
	"Beep in the presence of the sound system.
	Not to be used directly - use Beeper class>>beep
	or Beeper class>>beepPrimitive instead."

	(self new
			setSamples: self coffeeCupClink
			samplingRate: 12000) play
			