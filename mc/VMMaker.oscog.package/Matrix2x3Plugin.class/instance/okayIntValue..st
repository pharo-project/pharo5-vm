private
okayIntValue: value
	^(value >= interpreterProxy minSmallInteger asFloat
	  and: [value <= interpreterProxy maxSmallInteger asFloat])