transforming
transformPoint: srcPoint into: dstPoint
	"Transform srcPoint into dstPoint by using the currently loaded matrix"
	"Note: This method has been rewritten so that inlining works (e.g., removing
	the declarations and adding argument coercions at the appropriate points)"
	<inline: true>
	self transformPointX: ((self cCoerce: srcPoint to: 'int *') at: 0) asFloat 
		y: ((self cCoerce: srcPoint to:'int *') at: 1) asFloat
		into: (self cCoerce: dstPoint to: 'int *')