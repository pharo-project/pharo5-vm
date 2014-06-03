object access
fetchLong32: fieldIndex ofObject: oop
"fetchWord:ofObject: is rescinded as of VMMaker 3.8 64bit VM. This is the same code as used therein and may need revision for 64 bit cleanliness"
	^oop instVarAt: fieldIndex+1