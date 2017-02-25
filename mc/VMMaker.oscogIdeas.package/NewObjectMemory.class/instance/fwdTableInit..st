gc -- compaction
fwdTableInit: blkSize
	"Set the limits for a table of two- or three-word forwarding blocks above the last used oop. The pointer fwdTableNext moves up to fwdTableLast. Used for compaction of memory and become-ing objects. Returns the number of forwarding blocks available."

	<inline: false>
	"set endOfMemory to just after a minimum-sized free block"
	self setSizeOfFree: freeStart to: self baseHeaderSize.
	self setEndOfMemory: freeStart + self baseHeaderSize.

	"make a fake free chunk at endOfMemory for use as a sentinal in memory scans"
	self setSizeOfFree: endOfMemory to: self baseHeaderSize.

	"use all memory free between freeStart and memoryLimit for forwarding table"
	"Note: Forward blocks must be quadword aligned."
	fwdTableNext := (endOfMemory + self baseHeaderSize + 7) bitAnd: WordMask-7.
	self flag: #Dan.  "Above line does not do what it says (quadword is 16 or 32 bytes)"

	fwdTableLast := memoryLimit - blkSize.  "last forwarding table entry"

	"return the number of forwarding blocks available"
	^(fwdTableLast - fwdTableNext) // blkSize  "round down"