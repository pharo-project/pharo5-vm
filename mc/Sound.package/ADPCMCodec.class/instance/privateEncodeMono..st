private
privateEncodeMono: count

	| step sign diff delta predictedDelta bit p |
	<primitive: 'primitiveEncodeMono' module: 'ADPCMCodecPlugin'>
	
	<var: #stepSizeTable declareC: 'short int *stepSizeTable'>
	<var: #indexTable declareC: 'short int *indexTable'>
	<var: #samples declareC: 'short int *samples'>
	<var: #encodedBytes declareC: 'unsigned char *encodedBytes'>

	step := stepSizeTable at: 1.
	1 to: count do: [:i |
		(i bitAnd: frameSizeMask) = 1 ifTrue: [
			predicted := samples at: (sampleIndex := sampleIndex + 1).
			(p := predicted) < 0 ifTrue: [p := p + 65536].
			self nextBits: 16 put: p.
			i < count ifTrue: [
				index := self indexForDeltaFrom: predicted to: (samples at: sampleIndex + 1)].
			self nextBits: 6 put: index.
		] ifFalse: [
			"compute sign and magnitude of difference from the predicted sample"
			sign := 0.
			diff := (samples at: (sampleIndex := sampleIndex + 1)) - predicted.
			diff < 0 ifTrue: [
				sign := deltaSignMask.
				diff := 0 - diff].

			"Compute encoded delta and the difference that this will cause in the predicted sample value during decoding. Note that this code approximates:
				delta := (4 * diff) / step.
				predictedDelta := ((delta + 0.5) * step) / 4;
			but in the shift step bits are dropped. Thus, even if you have fast mul/div hardware you cannot use it since you would get slightly different bits what than the algorithm defines."
			delta := 0.
			predictedDelta := 0.
			bit := deltaValueHighBit.
			[bit > 0] whileTrue: [
				diff >= step ifTrue: [
					delta := delta + bit.
					predictedDelta := predictedDelta + step.
					diff := diff - step].
				step := step bitShift: -1.
				bit := bit bitShift: -1].
			predictedDelta := predictedDelta + step.

			"compute and clamp new prediction"
			sign > 0
				ifTrue: [predicted := predicted - predictedDelta]
				ifFalse: [predicted := predicted + predictedDelta].
			predicted > 32767
				ifTrue: [predicted := 32767]
				ifFalse: [predicted < -32768 ifTrue: [predicted := -32768]].

			"compute new index and step values"
			index := index + (indexTable at: delta + 1).
			index < 0
				ifTrue: [index := 0]
				ifFalse: [index > 88 ifTrue: [index := 88]].
			step := stepSizeTable at: index + 1.

			"output encoded, signed delta"
			self nextBits: bitsPerSample put: (sign bitOr: delta)]].

	bitPosition > 0 ifTrue: [  "flush the last output byte, if necessary"
		encodedBytes at: (byteIndex := byteIndex + 1) put: currentByte].
