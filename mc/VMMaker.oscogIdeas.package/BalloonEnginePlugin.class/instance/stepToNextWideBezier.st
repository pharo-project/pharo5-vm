beziers-wide
stepToNextWideBezier
	"Initialize the current entry in the GET by stepping to the current scan line"
	<inline: true>
	self stepToNextWideBezierIn: (aetBuffer at: self aetStartGet) at: self currentYGet.