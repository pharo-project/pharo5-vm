gc - global
markAndTrace: objOop
	"objOop = 16rB26020 ifTrue: [self halt].
	objOop = 16rB25FD8 ifTrue: [self halt].
	objOop = 16rB26010 ifTrue: [self halt]."
	^super markAndTrace: objOop