setup
destMaskAndPointerInit
	"Compute masks for left and right destination words"
	| startBits pixPerM1 endBits |
	<inline: true>
	pixPerM1 := destPPW - 1.  "A mask, assuming power of two"
	"how many pixels in first word"
	startBits := destPPW - (dx bitAnd: pixPerM1).
	destMSB
		ifTrue:[ mask1 := AllOnes >> (32 - (startBits*destDepth))] 
		ifFalse:[ mask1 := AllOnes << (32 - (startBits*destDepth))].
	"how many pixels in last word"
	endBits := ((dx + bbW - 1) bitAnd: pixPerM1) + 1.
	destMSB 
		ifTrue:[mask2 := AllOnes << (32 - (endBits*destDepth))] 
		ifFalse:[mask2 := AllOnes >> (32 - (endBits*destDepth))].
	"determine number of words stored per line; merge masks if only 1"
	bbW < startBits
		ifTrue: [mask1 := mask1 bitAnd: mask2.
				mask2 := 0.
				nWords := 1]
		ifFalse: [nWords := (bbW - startBits) + pixPerM1 // destPPW + 1].
	hDir := vDir := 1. "defaults for no overlap with source"

	"calculate byte addr and delta, based on first word of data"
	"Note pitch is bytes and nWords is longs, not bytes"
	destIndex := destBits + (dy * destPitch) + ((dx // destPPW) *4).
	destDelta := destPitch * vDir - (4 * (nWords * hDir)).  "byte addr delta"
