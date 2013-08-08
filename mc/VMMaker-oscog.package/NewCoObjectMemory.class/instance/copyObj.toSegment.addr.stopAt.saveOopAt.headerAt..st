image segment in/out
copyObj: oop toSegment: segmentWordArray addr: lastSeg stopAt: stopAddr saveOopAt: oopPtr headerAt: hdrPtr
	"Copy this object into the segment beginning at lastSeg.
	Install a forwarding pointer, and save oop and header.
	Fail if out of space.  Return the next segmentAddr if successful."

	"Copy the object..."
	| extraSize bodySize hdrAddr |
	<inline: false>
	self flag: #Dan.  "None of the imageSegment stuff has been updated for 64 bits"
	extraSize := self extraHeaderBytes: oop.
	bodySize := self sizeBitsOf: oop.
	(self oop: (lastSeg + extraSize + bodySize) isGreaterThanOrEqualTo: stopAddr) ifTrue:
		[^0]. "failure"
	self transfer: extraSize + bodySize // BytesPerWord  "wordCount"
		from: oop - extraSize
		to: lastSeg+BytesPerWord.

	"Clear root and mark bits of all headers copied into the segment"
	hdrAddr := lastSeg+BytesPerWord + extraSize.
	self longAt: hdrAddr put: ((self longAt: hdrAddr) bitAnd: AllButRootBit - MarkBit).

	"Make sure Cogged methods have their true header field written to the segment."
	((self isCompiledMethod: oop)
	and: [coInterpreter methodHasCogMethod: oop]) ifTrue:
		[self longAt: hdrAddr+BaseHeaderSize put: (coInterpreter headerOf: oop)].

	self forward: oop to: (lastSeg+BytesPerWord + extraSize - segmentWordArray)
		savingOopAt: oopPtr
		andHeaderAt: hdrPtr.

	"Return new end of segment"
	^lastSeg + extraSize + bodySize