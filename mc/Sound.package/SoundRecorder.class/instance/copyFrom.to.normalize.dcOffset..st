trimming
copyFrom: startPlace to: endPlace normalize: nFactor dcOffset: dcOffset
	"Return a new SoundBuffer containing the samples in the given range."

	| startBufIndex startSampleIndex endBufIndex endSampleIndex
	 count resultBuf j buf firstInBuf n |
	startBufIndex := startPlace at: 1.
	startSampleIndex := startPlace at: 2.
	endBufIndex := endPlace at: 1.
	endSampleIndex := endPlace at: 2.

	startBufIndex = endBufIndex
		ifTrue: [count := endSampleIndex + 1 - startSampleIndex]
		ifFalse: [
			count := ((recordedBuffers at: startBufIndex) size + 1 - startSampleIndex).  "first buffer"
			count := count + endSampleIndex.  "last buffer"
			startBufIndex + 1 to: endBufIndex - 1 do:
				[:i | count := count + (recordedBuffers at: i) size]].  "middle buffers"
	resultBuf := SoundBuffer newMonoSampleCount: count.

	j := 1.  "next destination index in resultBuf"
	startBufIndex to: endBufIndex do: [:i |
		buf := recordedBuffers at: i.
		firstInBuf := 1.
	 	n := buf size.
		i = startBufIndex ifTrue: [
			n := (recordedBuffers at: startBufIndex) size + 1 - startSampleIndex.
			firstInBuf := startSampleIndex].
		i = endBufIndex ifTrue: [
			i = startBufIndex
				ifTrue: [n := endSampleIndex + 1 - startSampleIndex]
				ifFalse: [n := endSampleIndex]].
		self copyTo: resultBuf from: j to: (j + n - 1)
			from: buf startingAt: firstInBuf
			normalize: nFactor dcOffset: dcOffset.
		j := j + n].
	^ resultBuf
