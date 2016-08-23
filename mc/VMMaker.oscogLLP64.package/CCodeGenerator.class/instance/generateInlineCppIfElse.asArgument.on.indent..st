C translation
generateInlineCppIfElse: msgNode asArgument: asArgument on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	| expr putStatement |
	"Compile-time expansion for constants set in the options dictionary,
	 e.g. to cut down on noise for MULTIPLEBYTECODESETS."
	putStatement := asArgument
		ifTrue: "emitCCodeAsArgumentOn: doesn't indent, the code needs indenting if it takes multiple lines, so post-process."
			[[:node| | expansion |
			  expansion := String streamContents: [:s| node emitCCodeAsArgumentOn: s level: level generator: self].
			  aStream nextPutAll:
			  ((expansion includes: Character cr)
				ifTrue:
					[(String streamContents:
							[:s|
							s position > 0 ifTrue: [s tab: level + 1].
							node emitCCodeAsArgumentOn: s level: level generator: self])
						copyReplaceAll: (String with: Character cr)
						with: (String with: Character cr), (String new: level + 1 withAll: Character tab)]
				ifFalse: [expansion])]]
		ifFalse:
			[[:node| | expansion |
			  expansion := String streamContents: [:s| node emitCCodeOn: s level: level generator: self].
			 "Remove tabs from first line to avoid indenting a second time"
			 expansion ifNotEmpty:
				[expansion := expansion allButFirst: (expansion findFirst: [:c| c ~~ Character tab]) - 1].
			 aStream nextPutAll: expansion]].

	(self nilOrBooleanConditionFor: msgNode) ifNotNil:
		[:condition|
		 condition
			ifTrue:
				[putStatement value: msgNode args second]
			ifFalse:
				[msgNode args size >= 3 ifTrue:
					[putStatement value: msgNode args third]].
		 ^self].

	"Full #if ... #else..."
	putStatement := asArgument
		ifTrue: "emitCCodeAsArgumentOn: doesn't indent, the code needs indenting in this case, so post-process."
			[[:node|
			  aStream nextPutAll:
				((String streamContents:
						[:s|
						s next: level + 1 put: Character tab.
						node emitCCodeAsArgumentOn: s level: level generator: self])
					copyReplaceAll: (String with: Character cr)
					with: (String with: Character cr), (String new: level + 1 withAll: Character tab))]]
		ifFalse:
			[[:node| node emitCCodeOn: aStream level: level generator: self]].

	expr := String streamContents:
				[:es|
				msgNode args first
					emitCCodeAsArgumentOn: es
					level: 0
					generator: self].
	[expr last isSeparator] whileTrue:
		[expr := expr allButLast].
	aStream
		ensureCr;
		nextPut: $#; next: level * 2 put: Character space; nextPutAll: 'if '; nextPutAll: expr; cr.

	self with: msgNode args first
		ifAppropriateSetTo: true
		do: [putStatement value: msgNode args second].
	expr := ' /* ', expr, ' */'.
	msgNode args size >= 3 ifTrue:
		[aStream
			ensureCr;
			nextPut: $#; next: level * 2 put: Character space; nextPutAll: 'else'; nextPutAll: expr;
			cr.
		self with: msgNode args first
			ifAppropriateSetTo: false
			do: [putStatement value: msgNode args third]].
	aStream
		ensureCr;
		nextPut: $#; next: level * 2 put: Character space; nextPutAll: 'endif'; nextPutAll: expr;
		cr.
	asArgument ifTrue:
		[aStream next: level + 1 put: Character tab]