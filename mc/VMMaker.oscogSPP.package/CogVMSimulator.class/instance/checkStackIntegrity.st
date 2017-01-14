object memory support
checkStackIntegrity
	"Override to deal with incomplete initialization."
	stackPages ifNil: [^true].
	stackPages pages ifNil: [^true].
	^super checkStackIntegrity