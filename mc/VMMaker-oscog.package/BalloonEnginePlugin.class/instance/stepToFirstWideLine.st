lines-wide
stepToFirstWideLine
	"Initialize the current entry in the GET by stepping to the current scan line"
	<inline: true>
	^self stepToFirstWideLineIn: (getBuffer at: self getStartGet) at: self currentYGet