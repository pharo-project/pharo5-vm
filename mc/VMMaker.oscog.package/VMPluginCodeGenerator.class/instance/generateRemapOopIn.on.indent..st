C translation
generateRemapOopIn: aNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	| arm |
	"Avoid nesting #if SPURVM...#else...#endif within arms of an outer #if SPURVM...#else...#endif."
	(Notification new tag: #inRemapOopInArm; signal) ifNotNil:
		[:inRemapOopInArm|
		 ^inRemapOopInArm
			ifTrue: [self generateSpurRemapOopIn: aNode on: aStream indent: level]
			ifFalse: [self generateV3RemapOopIn: aNode on: aStream indent: level]].
	[aStream cr; nextPutAll: '#if SPURVM'; cr.
	 arm := true.
	 self generateSpurRemapOopIn: aNode on: aStream indent: level.
	 aStream cr; nextPutAll: '#else /* SPURVM */'; cr.
	 arm := false.
	 self generateV3RemapOopIn: aNode on: aStream indent: level.
	 aStream cr; nextPutAll: '#endif /* SPURVM */'; cr]
		on: Notification
		do: [:ex|
			ex tag == #inRemapOopInArm
				ifTrue: [ex resume: arm]
				ifFalse: [ex pass]]