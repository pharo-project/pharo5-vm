private
scanStringFrom: aStream 
	| newString |
	newString := (String new: 40) writeStream.
	[aStream atEnd]
		whileFalse: 
			[| next | 
			next := aStream next.
			next == $% ifTrue: [^newString contents].
			next == $\
				ifTrue: 
					[next := aStream next.
					next == $n ifTrue: [next := Character cr].
					next == $t ifTrue: [next := Character tab]].
			newString nextPut: next].
	^newString contents