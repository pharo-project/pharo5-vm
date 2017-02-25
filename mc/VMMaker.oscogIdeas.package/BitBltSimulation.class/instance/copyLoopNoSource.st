inner loop
copyLoopNoSource
	"Faster copyLoop when source not used.  hDir and vDir are both
	positive, and perload and skew are unused"
	| halftoneWord mergeWord mergeFnwith destWord |
	<inline: false>
	<var: #mergeFnwith declareC: 'unsigned int (*mergeFnwith)(unsigned int, unsigned int)'>
	<var: #halftoneWord type: #'unsigned int'>
	<var: #mergeWord type: #'unsigned int'>
	<var: #destWord type: #'unsigned int'>
	mergeFnwith := self cCoerce: (opTable at: combinationRule+1) to: 'unsigned int (*)(unsigned int, unsigned int)'.
	mergeFnwith.  "null ref for compiler"

	1 to: bbH do: "here is the vertical loop"
		[ :i |
		noHalftone
			ifTrue: [halftoneWord := AllOnes]
			ifFalse: [halftoneWord := self halftoneAt: dy+i-1].

	"Note: the horizontal loop has been expanded into three parts for speed:"

			"This first section requires masking of the destination store..."
			destMask := mask1.
			destWord := self dstLongAt: destIndex.
			mergeWord := self mergeFn: halftoneWord
							with: destWord.
			destWord := (destMask bitAnd: mergeWord) bitOr: 
							(destWord bitAnd: destMask bitInvert32).
			self dstLongAt: destIndex put: destWord.
			self incDestIndex: 4.

		"This central horizontal loop requires no store masking"
			destMask := AllOnes.
			combinationRule = 3 ifTrue: ["Special inner loop for STORE"
				destWord := halftoneWord.
				2 to: nWords-1 do:[ :word |
					self dstLongAt: destIndex put: destWord.
					self incDestIndex: 4].
			] ifFalse:[ "Normal inner loop does merge"
				2 to: nWords-1 do:[ :word | "Normal inner loop does merge"
					destWord := self dstLongAt: destIndex.
					mergeWord := self mergeFn: halftoneWord with: destWord.
					self dstLongAt: destIndex put: mergeWord.
					self incDestIndex: 4].
			].

		"This last section, if used, requires masking of the destination store..."
		nWords > 1 ifTrue:
			[destMask := mask2.
			destWord := self dstLongAt: destIndex.
			mergeWord := self mergeFn: halftoneWord with: destWord.
			destWord := (destMask bitAnd: mergeWord) bitOr:
							(destWord bitAnd: destMask bitInvert32).
			self dstLongAt: destIndex put: destWord.
			self incDestIndex: 4].

	self incDestIndex: destDelta]