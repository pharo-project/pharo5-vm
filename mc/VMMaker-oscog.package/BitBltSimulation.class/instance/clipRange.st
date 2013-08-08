setup
clipRange
	"clip and adjust source origin and extent appropriately"
	"first in x"
	destX >= clipX
		ifTrue: [sx := sourceX.
				dx := destX.
				bbW := width]
		ifFalse: [sx := sourceX + (clipX - destX).
				bbW := width - (clipX - destX).
				dx := clipX].
	(dx + bbW) > (clipX + clipWidth)
		ifTrue: [bbW := bbW - ((dx + bbW) - (clipX + clipWidth))].
	"then in y"
	destY >= clipY
		ifTrue: [sy := sourceY.
				dy := destY.
				bbH := height]
		ifFalse: [sy := sourceY + clipY - destY.
				bbH := height - (clipY - destY).
				dy := clipY].
	(dy + bbH) > (clipY + clipHeight)
		ifTrue: [bbH := bbH - ((dy + bbH) - (clipY + clipHeight))].
	noSource ifTrue: [^ nil].
	sx < 0
		ifTrue: [dx := dx - sx.
				bbW := bbW + sx.
				sx := 0].
	sx + bbW > sourceWidth
		ifTrue: [bbW := bbW - (sx + bbW - sourceWidth)].
	sy < 0
		ifTrue: [dy := dy - sy.
				bbH := bbH + sy.
				sy := 0].
	sy + bbH > sourceHeight
		ifTrue: [bbH := bbH - (sy + bbH - sourceHeight)]