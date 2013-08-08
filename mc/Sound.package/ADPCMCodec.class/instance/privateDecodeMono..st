private
privateDecodeMono: count

	| delta step predictedDelta bit |
	<primitive: 'primitiveDecodeMono' module: 'ADPCMCodecPlugin'>
	
	<var: #stepSizeTable declareC: 'short int *stepSizeTable'>
	<var: #indexTable declareC: 'short int *indexTable'>
	<var: #samples declareC: 'short int *samples'>
	<var: #encodedBytes declareC: 'unsigned char *encodedBytes'>

	1 to: count do: [:i |
		(i bitAnd: frameSizeMask) = 1
			ifTrue: [  "start of frame; read frame header"
				predicted := self nextBits: 16.
				predicted > 32767 ifTrue: [predicted := predicted - 65536].
				index := self nextBits: 6.
				samples at: (sampleIndex := sampleIndex + 1) put: predicted]
			ifFalse: [
				delta := self nextBits: bitsPerSample.
				step := stepSizeTable at: index + 1.
				predictedDelta := 0.
				bit := deltaValueHighBit.
				[bit > 0] whileTrue: [
					(delta bitAnd: bit) > 0 ifTrue: [predictedDelta := predictedDelta + step].
					step := step bitShift: -1.
					bit := bit bitShift: -1].
				predictedDelta := predictedDelta + step.

				(delta bitAnd: deltaSignMask) > 0
					ifTrue: [predicted := predicted - predictedDelta]
					ifFalse: [predicted := predicted + predictedDelta].
				predicted > 32767
					ifTrue: [predicted := 32767]
					ifFalse: [predicted < -32768 ifTrue: [predicted := -32768]].

				index := index + (indexTable at: (delta bitAnd: deltaValueMask) + 1).
				index < 0
					ifTrue: [index := 0]
					ifFalse: [index > 88 ifTrue: [index := 88]].

				samples at: (sampleIndex := sampleIndex + 1) put: predicted]].
