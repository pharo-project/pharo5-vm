object memory support
preBecomeAction
	"((objectMemory instVarNamed: 'becomeEffectsFlags') anyMask: BecameCompiledMethodFlag) ifTrue:
		[self halt]."
	super preBecomeAction