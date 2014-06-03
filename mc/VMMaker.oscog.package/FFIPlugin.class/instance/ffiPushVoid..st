callout support
ffiPushVoid: ignored
	"This is a fallback in case somebody tries to pass a 'void' value.
	We could simply ignore the argument but I think it's better to let
	the caller know what he did"
	^self ffiFail: FFIErrorAttemptToPassVoid.