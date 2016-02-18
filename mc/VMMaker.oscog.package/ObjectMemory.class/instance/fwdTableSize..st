gc -- compaction
fwdTableSize: blkSize
	"Estimate the number of forwarding blocks available for compaction"
	| eom fwdFirst fwdLast |
	<inline: false>

	eom := freeBlock + self baseHeaderSize.
	"use all memory free between freeBlock and memoryLimit for forwarding table"

	"Note: Forward blocks must be quadword aligned."
	fwdFirst := (eom + self baseHeaderSize + 7) bitAnd: WordMask-7.
	self flag: #Dan.  "Above line does not do what it says (quadword is 16 or 32 bytes)"

	fwdLast := memoryLimit - blkSize.  "last forwarding table entry"

	"return the number of forwarding blocks available"
	^ (fwdLast - fwdFirst) // blkSize  "round down"