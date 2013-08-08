*Alien-Core
copyGrownBy: length
	| newCollection |
	newCollection := self species ofSize: self size + length.
	newCollection replaceFrom: 1 to: self size with: self startingAt: 1.
	^ newCollection