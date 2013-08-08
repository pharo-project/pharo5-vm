documentation
a6StuffTODO
	"This is an unordered list of things to do:

BalloonEnginePlugin>>stepToFirstBezierIn:at:
	1)	Check if reducing maxSteps from 2*deltaY to deltaY 
		brings a *significant* performance improvement.
		In theory this should make for double step performance
		but will cost in quality. Might be that the AA stuff will
		compensate for this - but I'm not really sure.

BalloonEngineBase>>dispatchOn:in:
	1)	Check what dispatches cost most and must be inlined
		by an #inlinedDispatchOn:in: Probably this will be
		stepping and eventually wide line stuff but we'll see.

BalloonEngineBase
	1)	Check which variables should become inst vars, if any.
		This will remove an indirection during memory access
		and might allow a couple of optimizations by the C compiler.

Anti-Aliasing:
	1)	Check if we can use a weighted 3x3 filter function of the form
				1	2	1
				2	4	2
				1	2	1
		Which should be *extremely* nice for fonts (it's sharpening
		edges). The good thing about the above is that it sums up to
		16 (as in the 4x4 case) but I don't know how to keep a history
		without needing two extra scan lines.

	2)	Check if we can - somehow - integrate more general filters.

	3) Unroll the loops during AA so we can copy and mask aaLevel pixels
	   in each step between start and end. This should speed up filling
	   by a factor of 2-4 (in particular for difficult stuff like radial gradients).

Clipping
	1)	Find a way of clipping edges left of the clip rectangle
		or at least ignoring most of them after the first scan line.
		The AET scanning problems discuss the issue but it should be
		possible to keep the color list between spans (if not empty)
		and speed up drawing at the very right (such as in the
		Winnie Pooh example where a lot of stuff is between the
		left border and the clipping rect.

	2)	Check if we can determine empty states of the color list and
		an edge that is longer than anything left of it. This should
		work in theory but might be relatively expensive to compute.

"
	^self error:'Comment only'