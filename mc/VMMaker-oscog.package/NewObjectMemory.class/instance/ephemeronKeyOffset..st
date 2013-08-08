ephemerons
ephemeronKeyOffset: oop

 "
	Answer the offset in bytes, to the ephemeron's key field.
	It should be the last (weak) slot of object.
"
	<inline: true>
	^ (self sizeBitsOfSafe: oop) - BaseHeaderSize.
