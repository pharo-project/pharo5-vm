setup
checkSourceOverlap
	"check for possible overlap of source and destination"
	"ar 10/19/1999: This method requires surfaces to be locked."
	| t |
	<inline: true>
	(sourceForm = destForm and: [dy >= sy]) ifTrue:
		[dy > sy ifTrue:
			["have to start at bottom"
			vDir := -1.
			sy := sy + bbH - 1.
			dy := dy + bbH - 1]
		ifFalse:
			[(dy = sy) & (dx > sx) ifTrue:
				["y's are equal, but x's are backward"
				hDir := -1.
				sx := sx + bbW - 1.
				"start at right"
				dx := dx + bbW - 1.
				"and fix up masks"
				nWords > 1 ifTrue: 
					[t := mask1.
					mask1 := mask2.
					mask2 := t]]].
		"Dest inits may be affected by this change"
		destIndex := destBits + (dy * destPitch) + ((dx // destPPW) *4).
		destDelta := (destPitch * vDir) - (4 * (nWords * hDir))]