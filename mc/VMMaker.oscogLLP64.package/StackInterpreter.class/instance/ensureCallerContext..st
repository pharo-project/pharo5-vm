frame access
ensureCallerContext: theFP
	"Answerr the caller context for a frame.  If the frame has a caller
	 frame that doesn't have a context, then marry the caller frame."
	| callerFP |
	<inline: true>
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	callerFP := self frameCallerFP: theFP.
	callerFP = 0 ifTrue: "base frame, context in saved ip slot (or base of stack in Cog)"
		[^self frameCallerContext: theFP].
	^self ensureFrameIsMarried: callerFP SP: (self frameCallerStackPointer: theFP)