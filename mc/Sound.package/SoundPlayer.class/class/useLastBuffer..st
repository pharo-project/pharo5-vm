initialization
useLastBuffer: aBool
	Buffer ifNil:[^self].
	aBool 
		ifTrue:[LastBuffer := SoundBuffer basicNew: Buffer basicSize]
		ifFalse:[LastBuffer := nil]	