inner loop
copyLoop
	| prevWord thisWord skewWord halftoneWord mergeWord hInc y unskew skewMask notSkewMask mergeFnwith destWord |
	"This version of the inner loop assumes noSource = false."
	<inline: false>
	<var: #mergeFnwith declareC: 'unsigned int (*mergeFnwith)(unsigned int, unsigned int)'>
	<var: #prevWord type: #'unsigned int'>
	<var: #thisWord type: #'unsigned int'>
	<var: #skewWord type: #'unsigned int'>
	<var: #halftoneWord type: #'unsigned int'>
	<var: #mergeWord type: #'unsigned int'>
	<var: #destWord type: #'unsigned int'>
	<var: #skewMask type: #'unsigned int'>
	<var: #notSkewMask type: #'unsigned int'>
	mergeFnwith := self cCoerce: (opTable at: combinationRule+1) to: 'unsigned int (*)(unsigned int, unsigned int)'.
	mergeFnwith.  "null ref for compiler"

	hInc := hDir*4.  "Byte delta"
	"degenerate skew fixed for Sparc. 10/20/96 ikp"
	skew == -32
		ifTrue: [skew := unskew := skewMask := 0]
		ifFalse: [skew < 0
			ifTrue:
				[unskew := skew+32.
				skewMask := AllOnes << (0-skew)]
			ifFalse:
				[skew = 0
					ifTrue:
						[unskew := 0.
						skewMask := AllOnes]
					ifFalse:
						[unskew := skew-32.
						skewMask := AllOnes >> skew]]].
	notSkewMask := skewMask bitInvert32.
	noHalftone
		ifTrue: [halftoneWord := AllOnes.  halftoneHeight := 0]
		ifFalse: [halftoneWord := self halftoneAt: 0].

	y := dy.
	1 to: bbH do: "here is the vertical loop"
		[ :i |
		halftoneHeight > 1 ifTrue:  "Otherwise, its always the same"
			[halftoneWord := self halftoneAt: y.
			y := y + vDir].
		preload ifTrue:
			["load the 64-bit shifter"
			prevWord := self srcLongAt: sourceIndex.
			self incSrcIndex: hInc]
			ifFalse:
			[prevWord := 0].

	"Note: the horizontal loop has been expanded into three parts for speed:"

			"This first section requires masking of the destination store..."
			destMask := mask1.
			thisWord := self srcLongAt: sourceIndex.  "pick up next word"
			self incSrcIndex: hInc.
			skewWord := ((prevWord bitAnd: notSkewMask) bitShift: unskew)
							bitOr:  "32-bit rotate"
						((thisWord bitAnd: skewMask) bitShift: skew).
			prevWord := thisWord.
			destWord := self dstLongAt: destIndex.
			mergeWord := self mergeFn: (skewWord bitAnd: halftoneWord) with: destWord.
			destWord := (destMask bitAnd: mergeWord) bitOr:
							(destWord bitAnd: destMask bitInvert32).
			self dstLongAt: destIndex put: destWord.
			self incDestIndex: hInc.

		"This central horizontal loop requires no store masking"
		destMask := AllOnes.
combinationRule = 3
ifTrue: [(skew = 0) & (halftoneWord = AllOnes)
		ifTrue: 
		["Very special inner loop for STORE mode with no skew -- just move words"
		hDir = -1
		ifTrue: ["Woeful patch: revert to older code for hDir = -1"
				2 to: nWords-1 do: 
					[ :word |
					thisWord := self srcLongAt: sourceIndex.
					self incSrcIndex: hInc.
					self dstLongAt: destIndex put: thisWord.
					self incDestIndex: hInc]]
		ifFalse: [2 to: nWords-1 do: 
					[ :word |  "Note loop starts with prevWord loaded (due to preload)"
					self dstLongAt: destIndex put: prevWord.
					self incDestIndex: hInc.
					prevWord := self srcLongAt: sourceIndex.
					self incSrcIndex: hInc]]]
		ifFalse:
		["Special inner loop for STORE mode -- no need to call merge"
		2 to: nWords-1 do: 
			[ :word |
			thisWord := self srcLongAt: sourceIndex.
			self incSrcIndex: hInc.
			skewWord := ((prevWord bitAnd: notSkewMask) bitShift: unskew)
							bitOr:  "32-bit rotate"
						((thisWord bitAnd: skewMask) bitShift: skew).
			prevWord := thisWord.
			self dstLongAt: destIndex put: (skewWord bitAnd: halftoneWord).
			self incDestIndex: hInc]]
] ifFalse: [2 to: nWords-1 do: "Normal inner loop does merge:"
			[ :word |
			thisWord := self srcLongAt: sourceIndex.  "pick up next word"
			self incSrcIndex: hInc.
			skewWord := ((prevWord bitAnd: notSkewMask) bitShift: unskew)
							bitOr:  "32-bit rotate"
						((thisWord bitAnd: skewMask) bitShift: skew).
			prevWord := thisWord.
			mergeWord := self mergeFn: (skewWord bitAnd: halftoneWord)
							with: (self dstLongAt: destIndex).
			self dstLongAt: destIndex put: mergeWord.
			self incDestIndex: hInc]
].

		"This last section, if used, requires masking of the destination store..."
		nWords > 1 ifTrue:
			[destMask := mask2.
			thisWord := self srcLongAt: sourceIndex.  "pick up next word"
			self incSrcIndex: hInc.
			skewWord := ((prevWord bitAnd: notSkewMask) bitShift: unskew)
							bitOr:  "32-bit rotate"
						((thisWord bitAnd: skewMask) bitShift: skew).
			destWord := self dstLongAt: destIndex.
			mergeWord := self mergeFn: (skewWord bitAnd: halftoneWord) with: destWord.
			destWord := (destMask bitAnd: mergeWord) bitOr:
							(destWord bitAnd: destMask bitInvert32).
			self dstLongAt: destIndex put: destWord.
			self incDestIndex: hInc].

	self incSrcIndex: sourceDelta.
	self incDestIndex: destDelta]