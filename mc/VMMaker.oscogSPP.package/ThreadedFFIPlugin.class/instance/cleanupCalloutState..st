callout support
cleanupCalloutState: calloutState
	<var: #calloutState type: #'CalloutState *'>
	<returnTypeC: #void>
	"Free any temporary arg strings."
	<inline: true>
	[calloutState stringArgIndex > 0] whileTrue:
		[self free: (calloutState stringArgs at: (calloutState stringArgIndex: calloutState stringArgIndex - 1))]