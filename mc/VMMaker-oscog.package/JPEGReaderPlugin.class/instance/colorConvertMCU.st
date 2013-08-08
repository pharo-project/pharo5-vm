decoding
colorConvertMCU
	| y cb cr red green blue |
	yComponent at: CurrentXIndex put: 0.
	yComponent at: CurrentYIndex put: 0.
	cbComponent at: CurrentXIndex put: 0.
	cbComponent at: CurrentYIndex put: 0.
	crComponent at: CurrentXIndex put: 0.
	crComponent at: CurrentYIndex put: 0.
	0 to: jpegBitsSize-1 do:[:i|
		y := self nextSampleY.
		cb := self nextSampleCb.
		cb := cb - SampleOffset.
		cr := self nextSampleCr.
		cr := cr - SampleOffset.
		red := y + ((FIXn1n40200 * cr) // 65536) + (residuals at: RedIndex).
		red := red min: MaxSample. red := red max: 0.
		residuals at: RedIndex put: (red bitAnd: ditherMask).
		red := red bitAnd: MaxSample - ditherMask.
		red := red max: 1.
		green := y - ((FIXn0n34414 * cb) // 65536) -
			((FIXn0n71414 * cr) // 65536) + (residuals at: GreenIndex).
		green := green min: MaxSample. green := green max: 0.
		residuals at: GreenIndex put: (green bitAnd: ditherMask).
		green := green bitAnd: MaxSample - ditherMask.
		green := green max: 1.
		blue := y + ((FIXn1n77200 * cb) // 65536) + (residuals at: BlueIndex).
		blue := blue min: MaxSample. blue := blue max: 0.
		residuals at: BlueIndex put: (blue bitAnd: ditherMask).
		blue := blue bitAnd: MaxSample - ditherMask.
		blue := blue max: 1.
		jpegBits at: i put: 16rFF000000 + (red bitShift: 16) + (green bitShift: 8) + blue.
	].