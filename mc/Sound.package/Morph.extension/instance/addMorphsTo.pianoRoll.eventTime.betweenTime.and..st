*sound-piano rolls
addMorphsTo: morphList pianoRoll: pianoRoll eventTime: t betweenTime: leftTime and: rightTime

	"a hack to allow for abitrary morphs to be dropped into piano roll"
	t > rightTime ifTrue: [^ self].  
	t < leftTime ifTrue: [^ self].
	morphList add: (self left: (pianoRoll xForTime: t)).
