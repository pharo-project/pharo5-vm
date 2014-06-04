interpreter interface
loadHalftoneForm
	"Load the halftone form"
	| halftoneBits |
	<inline: true>
	noHalftone ifTrue:[
		halftoneBase := nil.
		^true].
	((interpreterProxy isPointers: halftoneForm) and: [(interpreterProxy slotSizeOf: halftoneForm) >= 4])
		ifTrue:
		["Old-style 32xN monochrome halftone Forms"
		halftoneBits := interpreterProxy fetchPointer: FormBitsIndex ofObject: halftoneForm.
		halftoneHeight := interpreterProxy fetchInteger: FormHeightIndex ofObject: halftoneForm.
		(interpreterProxy isWords: halftoneBits)
			ifFalse: [noHalftone := true]]
		ifFalse:
		["New spec accepts, basically, a word array"
		((interpreterProxy isPointers: halftoneForm) not
			and: [interpreterProxy isWords: halftoneForm])
			ifFalse: [^ false].
		halftoneBits := halftoneForm.
		halftoneHeight := interpreterProxy slotSizeOf: halftoneBits].
	halftoneBase := self oopForPointer: (interpreterProxy firstIndexableField: halftoneBits).
	^true