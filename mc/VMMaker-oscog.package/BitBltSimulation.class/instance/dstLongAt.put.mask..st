memory access
dstLongAt: idx put: srcValue mask: dstMask
	"Store the given value back into destination form, using dstMask
	to mask out the bits to be modified. This is an essiantial
	read-modify-write operation on the destination form."
	| dstValue |
	<inline: true>
	dstValue := self dstLongAt: idx.
	dstValue := dstValue bitAnd: dstMask.
	dstValue := dstValue bitOr: srcValue.
	self dstLongAt: idx put: dstValue.