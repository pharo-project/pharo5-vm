weakness and ephemerality
noUnfiredEphemeronsAtEndOfRememberedSet
	"For assert checking only."
	numRememberedEphemerons to: rememberedSetSize - 1 do:
		[:i| | referrer |
		referrer := rememberedSet at: i.
		(manager isEphemeron: referrer) ifTrue:
			[(self isScavengeSurvivor: (manager keyOfEphemeron: referrer)) ifFalse:
				[^false]]].
	^true