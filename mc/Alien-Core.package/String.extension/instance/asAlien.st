*Alien-Core
asAlien
	| size alien |
	size := self byteSize.
	alien := Alien newC: size + 1.
	alien replaceFrom: 1 to: size with: self startingAt: 1.
	^ alien