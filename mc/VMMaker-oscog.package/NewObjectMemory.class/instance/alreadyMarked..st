gc -- mark and sweep
alreadyMarked: oop
	"answer true if oop is already marked or belongs to old space "
	<inline: true>
	^ ((self oop: oop isLessThan: youngStartLocal) "old object; skip it"
	 or: [((self longAt: oop) bitAnd: MarkBit) ~= 0]) "already marked; skip it"
