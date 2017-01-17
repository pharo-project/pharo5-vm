interpreter interface
loadColorMap
	"ColorMap, if not nil, must be longWords, and 
	2^N long, where N = sourceDepth for 1, 2, 4, 8 bits, 
	or N = 9, 12, or 15 (3, 4, 5 bits per color) for 16 or 32 bits."
	| cmSize oldStyle oop cmOop |
	<inline: true>
	cmFlags := cmMask := cmBitsPerColor := 0.
	cmShiftTable := nil.
	cmMaskTable := nil.
	cmLookupTable := nil.
	cmOop := interpreterProxy fetchPointer: BBColorMapIndex ofObject: bitBltOop.
	cmOop = interpreterProxy nilObject ifTrue:[^true].
	cmFlags := ColorMapPresent. "even if identity or somesuch - may be cleared later"
	oldStyle := false.
	(interpreterProxy isWords: cmOop) ifTrue:[
		"This is an old-style color map (indexed only, with implicit RGBA conversion)"
		cmSize := interpreterProxy slotSizeOf: cmOop.
		cmLookupTable := interpreterProxy firstIndexableField: cmOop.
		oldStyle := true.
	] ifFalse: [
		"A new-style color map (fully qualified)"
		((interpreterProxy isPointers: cmOop) 
			and:[(interpreterProxy slotSizeOf: cmOop) >= 3]) ifFalse:[^false].
		cmShiftTable := self loadColorMapShiftOrMaskFrom:
			(interpreterProxy fetchPointer: 0 ofObject: cmOop).
		cmMaskTable := self loadColorMapShiftOrMaskFrom:
			(interpreterProxy fetchPointer: 1 ofObject: cmOop).
		oop := interpreterProxy fetchPointer: 2 ofObject: cmOop.
		oop = interpreterProxy nilObject 
			ifTrue:[cmSize := 0]
			ifFalse:[(interpreterProxy isWords: oop) ifFalse:[^false].
					cmSize := (interpreterProxy slotSizeOf: oop).
					cmLookupTable := interpreterProxy firstIndexableField: oop].
		cmFlags := cmFlags bitOr: ColorMapNewStyle.
		self cCode: '' inSmalltalk:
			[].
	].
	(cmSize bitAnd: cmSize - 1) = 0 ifFalse:[^false].
	cmMask := cmSize - 1.
	cmBitsPerColor := 0.
	cmSize = 512 ifTrue: [cmBitsPerColor := 3].
	cmSize = 4096 ifTrue: [cmBitsPerColor := 4].
	cmSize = 32768 ifTrue: [cmBitsPerColor := 5].
	cmSize = 0
		ifTrue:[cmLookupTable := nil. cmMask := 0]
		ifFalse:[cmFlags := cmFlags bitOr: ColorMapIndexedPart].
	oldStyle "needs implicit conversion"
		ifTrue:[	self setupColorMasks].
	"Check if colorMap is just identity mapping for RGBA parts"
	(self isIdentityMap: cmShiftTable with: cmMaskTable)
		ifTrue:[ cmMaskTable := nil. cmShiftTable := nil ]
		ifFalse:[ cmFlags := cmFlags bitOr: ColorMapFixedPart].
	^true