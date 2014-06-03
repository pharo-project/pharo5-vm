debug support
checkOkayStackZone: writeBack
	"Check that all objects in the stack zone are okay"
	| ok thePage |
	<var: #thePage type: #'StackPage *'>
	<inline: false>
	writeBack ifTrue:
		[self externalWriteBackHeadFramePointers].
	ok := true.

	0 to: numStackPages - 1 do:
		[:i|
		thePage := stackPages stackPageAt: i.
		(stackPages isFree: thePage) ifFalse:
			[ok := ok & (self checkOkayStackPage: thePage)]].

	^ok