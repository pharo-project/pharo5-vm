gc -- compaction
remapRemapBufferAndExtraRoots
	| oop |
	1 to: remapBufferCount do:
		[:i |
		oop := remapBuffer at: i.
		(self shouldRemapOop: oop) ifTrue:
			[remapBuffer at: i put: (self remapObj: oop)]].
	1 to: extraRootCount do:
		[:i |
		oop := (extraRoots at: i) at: 0.
		((self isIntegerObject: oop) or: [self isFreeObject: oop]) ifFalse:
			[(self shouldRemapObj: oop) ifTrue:
				[(extraRoots at: i) at: 0 put: (self remapObj: oop)]]]