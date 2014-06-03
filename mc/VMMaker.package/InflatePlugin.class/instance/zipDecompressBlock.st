inflating
zipDecompressBlock
	| value extra length distance oldPos oldBits oldBitPos dstPos srcPos max |
	<inline: false>
	max := zipCollectionSize - 1.
	[zipReadLimit < max and:[zipSourcePos <= zipSourceLimit]] whileTrue:[
		"Back up stuff if we're running out of space"
		oldBits := zipBitBuf.
		oldBitPos := zipBitPos.
		oldPos := zipSourcePos.
		value := self zipDecodeValueFrom: zipLitTable size: zipLitTableSize.
		value < 256 ifTrue:[ "A literal"
			zipCollection at: (zipReadLimit := zipReadLimit + 1) put: value.
		] ifFalse:["length/distance or end of block"
			value = 256 ifTrue:["End of block"
				zipState := zipState bitAnd: StateNoMoreData.
				^0].
			"Compute the actual length value (including possible extra bits)"
			extra := (value bitShift: -16) - 1.
			length := value bitAnd: 16rFFFF.
			extra > 0 ifTrue:[length := length + (self zipNextBits: extra)].
			"Compute the distance value"
			value := self zipDecodeValueFrom: zipDistTable size: zipDistTableSize.
			extra := (value bitShift: -16).
			distance := value bitAnd: 16rFFFF.
			extra > 0 ifTrue:[distance := distance + (self zipNextBits: extra)].
			(zipReadLimit + length >= max) ifTrue:[
				zipBitBuf := oldBits.
				zipBitPos := oldBitPos.
				zipSourcePos := oldPos.
				^0].
			dstPos := zipReadLimit.
			srcPos := zipReadLimit - distance.
			1 to: length do:[:i|
				zipCollection at: dstPos+i put: (zipCollection at: srcPos+i)].
			zipReadLimit := zipReadLimit + length.
		].
	].