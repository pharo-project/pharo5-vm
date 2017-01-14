primitives
primitiveReadJoystick: index
	"Read an input word from the joystick with the given index."

	self primitive: 'primitiveReadJoystick'
		parameters: #(SmallInteger).
	^(self joystickRead: index) asPositiveIntegerObj