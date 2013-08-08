composition
removeFirstCompleteSoundOrNil
	"Remove the first sound if it has been completely recorded."

	| firstSound |

	sounds size > 0 ifFalse: [^ nil].
	firstSound := sounds first.
	sounds := sounds copyFrom: 2 to: sounds size.
	^firstSound
