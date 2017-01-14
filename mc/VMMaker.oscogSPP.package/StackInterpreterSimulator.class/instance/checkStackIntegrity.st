object memory support
checkStackIntegrity
	"Override to deal with incomplete initialization."
	stackPages ifNil: [^true].
	^super checkStackIntegrity