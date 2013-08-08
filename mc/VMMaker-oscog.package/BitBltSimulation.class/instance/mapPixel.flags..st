color mapping
mapPixel: sourcePixel flags: mapperFlags
	"Color map the given source pixel."
	| pv |
	<inline: true>
	pv := sourcePixel.
	(mapperFlags bitAnd: ColorMapPresent) ~= 0 ifTrue:[
		(mapperFlags bitAnd: ColorMapFixedPart) ~= 0 ifTrue:[
			pv := self rgbMapPixel: sourcePixel flags: mapperFlags.
			"avoid introducing transparency by color reduction"
			(pv = 0 and:[sourcePixel ~= 0]) ifTrue:[pv := 1]].
		(mapperFlags bitAnd: ColorMapIndexedPart) ~= 0
			ifTrue:[pv := cmLookupTable at: (pv bitAnd: cmMask)].
	].
	^pv