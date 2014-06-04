accessing
usedSize
	^last < start
		ifTrue: [0]
		ifFalse:
			[last >= first
				ifTrue: [last - first / manager wordSize + 1]
				ifFalse: [limit - start - (first - last) / manager wordSize - 1]]