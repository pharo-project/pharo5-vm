gc - global
mapExtraRoots
	(self shouldRemapObj: specialObjectsOop) ifTrue:
		[specialObjectsOop := self remapObj: specialObjectsOop].
	self assert: remapBufferCount = 0.
	"1 to: remapBufferCount do:
		[:i | | oop |
		oop := remapBufferCount at: i.
		((self isImmediate: oop) or: [self isFreeObject: oop]) ifFalse:
			[(self shouldRemapObj: oop) ifTrue:
				[remapBuffer at: i put: (self remapObj: oop)]]]."
	1 to: extraRootCount do:
		[:i | | oop |
		oop := (extraRoots at: i) at: 0.
		((self isImmediate: oop) or: [self isFreeObject: oop]) ifFalse:
			[(self shouldRemapObj: oop) ifTrue:
				[(extraRoots at: i) at: 0 put: (self remapObj: oop)]]]