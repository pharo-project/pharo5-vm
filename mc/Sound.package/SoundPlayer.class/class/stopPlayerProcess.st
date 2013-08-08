player process
stopPlayerProcess
	"Stop the sound player process."
	"SoundPlayer stopPlayerProcess"

	(PlayerProcess == nil or:[PlayerProcess == Processor activeProcess]) 
		ifFalse:[PlayerProcess terminate].
	PlayerProcess := nil.
	self primSoundStop.
	ActiveSounds := OrderedCollection new.
	Buffer := nil.
	PlayerSemaphore := Semaphore forMutualExclusion.
	ReadyForBuffer ifNotNil:
		[Smalltalk unregisterExternalObject: ReadyForBuffer].
	ReadyForBuffer := nil.
