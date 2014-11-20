private
okayIntValue: value
	^(value >= interpreterProxy minSmallInteger asFloat
	  and: [m23ResultX <= interpreterProxy maxSmallInteger asFloat])