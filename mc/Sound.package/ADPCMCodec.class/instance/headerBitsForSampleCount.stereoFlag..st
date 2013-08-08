private
headerBitsForSampleCount: sampleCount stereoFlag: stereoFlag
	"Answer the number of extra header bits required for the given number of samples. This will be zero if I am not using frame headers."

	| frameCount bitsPerHeader |
	frameSizeMask = 0 ifTrue: [^ 0].
	frameCount := (sampleCount / self samplesPerFrame) ceiling.
	bitsPerHeader := 16 + 6.
	stereoFlag ifTrue: [bitsPerHeader := 2 * bitsPerHeader].
	^ frameCount * bitsPerHeader
