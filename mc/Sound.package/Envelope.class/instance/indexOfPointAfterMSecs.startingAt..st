private
indexOfPointAfterMSecs: mSecs startingAt: startIndex
	"Return the index of the first point whose time is greater that mSecs, starting with the given index. Return nil if mSecs is after the last point's time."

	startIndex to: points size do:
		[:i | (points at: i) x > mSecs ifTrue: [^ i]].
	^ nil
