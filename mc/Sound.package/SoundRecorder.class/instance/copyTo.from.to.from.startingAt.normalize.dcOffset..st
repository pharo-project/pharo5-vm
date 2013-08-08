trimming
copyTo: resultBuf from: startIndex to: endIndex from: buf startingAt: firstInBuf normalize: nFactor dcOffset: dcOffset
	"Copy samples from buf to resultBuf removing the DC offset and normalizing their volume in the process."

	| indexOffset |
	indexOffset := firstInBuf - startIndex.
	startIndex to: endIndex do: [:i |
		resultBuf at: i put: (((buf at: (i + indexOffset)) - dcOffset) * nFactor) // 1000].
