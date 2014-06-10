This class implements BitBlt, much as specified in the Blue Book spec.

Performance has been enhanced through the use of pointer variables such as sourceIndex and destIndex, and by separating several special cases of the inner loop.

Operation has been extended to color, with support for 1, 2, 4, 8, 16, and 32-bit pixel sizes.  Conversion between different pixel sizes is facilitated by accepting an optional color map.

In addition to the original 16 combination rules, this BitBlt supports
	16	fail (for old paint mode)
	17	fail (for old mask mode)
	18	sourceWord + destinationWord
	19	sourceWord - destinationWord
	20	rgbAdd: sourceWord with: destinationWord
	21	rgbSub: sourceWord with: destinationWord
	22	OLDrgbDiff: sourceWord with: destinationWord
	23	OLDtallyIntoMap: destinationWord -- old vers doesn't clip to bit boundary
	24	alphaBlend: sourceWord with: destinationWord
	25	pixPaint: sourceWord with: destinationWord
	26	pixMask: sourceWord with: destinationWord
	27	rgbMax: sourceWord with: destinationWord
	28	rgbMin: sourceWord with: destinationWord
	29	rgbMin: sourceWord bitInvert32 with: destinationWord
	30	alphaBlendConst: sourceWord with: destinationWord -- alpha passed as an arg
	31	alphaPaintConst: sourceWord with: destinationWord -- alpha passed as an arg
	32	rgbDiff: sourceWord with: destinationWord
	33	tallyIntoMap: destinationWord
	34	alphaBlendScaled: sourceWord with: destinationWord
	35 alphaBlendScaled: sourceWord with:	"unused here - only used by FXBlt"
	36 alphaBlendScaled: sourceWord with:	"unused here - only used by FXBlt"
	37 rgbMul: sourceWord with: destinationWord
	38 pixSwap: sourceWord with: destinationWord
	39 pixClear: sourceWord with: destinationWord
	40 fixAlpha: sourceWord with: destinationWord
	41 rgbComponentAlpha: sourceWord with: destinationWord

This implementation has also been fitted with an experimental "warp drive" that allows abritrary scaling and rotation (and even limited affine deformations) with all BitBlt storage modes supported.

To add a new rule to BitBlt...
	1.  add the new rule method or methods in the category 'combination rules' of BBSim
	2.  describe it in the class comment  of BBSim and in the class comment for BitBlt
	3.  add refs to initializeRuleTable in proper positions
	4.  add refs to initBBOpTable, following the pattern
