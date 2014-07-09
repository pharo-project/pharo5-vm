instance creation
bottomUpTree: anItem depth: anInteger
	^(anInteger > 0)
		ifTrue: [
			self
				left: (self bottomUpTree: 2*anItem - 1 depth: anInteger - 1)
				right: (self bottomUpTree: 2*anItem depth: anInteger - 1) 
				item: anItem
			]
		ifFalse: [self left: nil right: nil item: anItem]