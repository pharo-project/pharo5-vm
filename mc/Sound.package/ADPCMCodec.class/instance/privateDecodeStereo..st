private
privateDecodeStereo: count

	| predictedLeft predictedRight indexLeft indexRight deltaLeft deltaRight
	 stepLeft stepRight predictedDeltaLeft predictedDeltaRight bit |

	<primitive: 'primitiveDecodeStereo' module: 'ADPCMCodecPlugin'>
	
	<var: #stepSizeTable declareC: 'short int *stepSizeTable'>
	<var: #indexTable declareC: 'short int *indexTable'>
	<var: #samples declareC: 'short int *samples'>
	<var: #encodedBytes declareC: 'unsigned char *encodedBytes'>
	<var: #rightSamples declareC: 'short int *rightSamples'>
	<var: #predicted declareC: 'short int *predicted'>
	<var: #index declareC: 'short int *index'>

	"make local copies of decoder state variables"
	predictedLeft := predicted at: 1.
	predictedRight := predicted at: 2.
	indexLeft := index at: 1.
	indexRight := index at: 2.

	1 to: count do: [:i |
		(i bitAnd: frameSizeMask) = 1
			ifTrue: [  "start of frame; read frame header"
				predictedLeft := self nextBits: 16.
				indexLeft := self nextBits: 6.
				predictedRight := self nextBits: 16.
				indexRight := self nextBits: 6.
				predictedLeft > 32767 ifTrue: [predictedLeft := predictedLeft - 65536].
				predictedRight > 32767 ifTrue: [predictedRight := predictedRight - 65536].
				samples at: (sampleIndex := sampleIndex + 1) put: predictedLeft.
				rightSamples at: sampleIndex put: predictedRight]
			ifFalse: [
				deltaLeft := self nextBits: bitsPerSample.
				deltaRight := self nextBits: bitsPerSample.
				stepLeft := stepSizeTable at: indexLeft + 1.
				stepRight := stepSizeTable at: indexRight + 1.
				predictedDeltaLeft := predictedDeltaRight := 0.
				bit := deltaValueHighBit.
				[bit > 0] whileTrue: [
					(deltaLeft bitAnd: bit) > 0 ifTrue: [
						predictedDeltaLeft := predictedDeltaLeft + stepLeft].
					(deltaRight bitAnd: bit) > 0 ifTrue: [
						predictedDeltaRight := predictedDeltaRight + stepRight].
					stepLeft := stepLeft bitShift: -1.
					stepRight := stepRight bitShift: -1.
					bit := bit bitShift: -1].
				predictedDeltaLeft := predictedDeltaLeft + stepLeft.
				predictedDeltaRight := predictedDeltaRight + stepRight.

				(deltaLeft bitAnd: deltaSignMask) > 0
					ifTrue: [predictedLeft := predictedLeft - predictedDeltaLeft]
					ifFalse: [predictedLeft := predictedLeft + predictedDeltaLeft].
				(deltaRight bitAnd: deltaSignMask) > 0
					ifTrue: [predictedRight := predictedRight - predictedDeltaRight]
					ifFalse: [predictedRight := predictedRight + predictedDeltaRight].
				predictedLeft > 32767
					ifTrue: [predictedLeft := 32767]
					ifFalse: [predictedLeft < -32768 ifTrue: [predictedLeft := -32768]].
				predictedRight > 32767
					ifTrue: [predictedRight := 32767]
					ifFalse: [predictedRight < -32768 ifTrue: [predictedRight := -32768]].

				indexLeft := indexLeft + (indexTable at: (deltaLeft bitAnd: deltaValueMask) + 1).
				indexLeft < 0
					ifTrue: [indexLeft := 0]
					ifFalse: [indexLeft > 88 ifTrue: [indexLeft := 88]].
				indexRight := indexRight + (indexTable at: (deltaRight bitAnd: deltaValueMask) + 1).
				indexRight < 0
					ifTrue: [indexRight := 0]
					ifFalse: [indexRight > 88 ifTrue: [indexRight := 88]].

				samples at: (sampleIndex := sampleIndex + 1) put: predictedLeft.
				rightSamples at: sampleIndex put: predictedRight]].

	"save local copies of decoder state variables"
	predicted at: 1 put: predictedLeft.
	predicted at: 2 put: predictedRight.
	index at: 1 put: indexLeft.
	index at: 2 put: indexRight.
