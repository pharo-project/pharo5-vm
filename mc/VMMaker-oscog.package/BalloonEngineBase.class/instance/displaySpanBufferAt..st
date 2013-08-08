displaying
displaySpanBufferAt: y
	"Display the span buffer at the current scan line."
	| targetX0 targetX1 targetY |
	<inline: false>
	"self aaLevelGet > 1 ifTrue:[self adjustAALevel]."
	targetX0 := self spanStartGet >> self aaShiftGet.
	targetX0 < self clipMinXGet ifTrue:[targetX0 := self clipMinXGet].
	targetX1 := (self spanEndGet + self aaLevelGet - 1) >> self aaShiftGet.
	targetX1 > self clipMaxXGet ifTrue:[targetX1 := self clipMaxXGet].
	targetY := y >> self aaShiftGet.
	(targetY < self clipMinYGet or:[targetY >= self clipMaxYGet or:[
		targetX1 < self clipMinXGet or:[targetX0 >= self clipMaxXGet]]]) ifTrue:[^0].
	self copyBitsFrom: targetX0 to: targetX1 at: targetY.