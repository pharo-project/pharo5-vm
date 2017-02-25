allocation
newObjectHash
	"Derive the new object hash from the allocation pointer.  This is less costly than
	 using lastHash because it avoids the read-modify-write cycle to update lastHash.
	 Since the size of eden is a power of two and larger than the hash range this provides
	 a well-distributed and fairly random set of values."
	<inline: true>
	^freeStart >> self shiftForWord