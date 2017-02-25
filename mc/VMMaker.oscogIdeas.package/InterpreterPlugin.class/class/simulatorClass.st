simulation
simulatorClass
	"For running from Smalltalk - answer a class that can be used to simulate the receiver, or nil if you want the primitives in this module to always fail, causing simulation to fall through to the Smalltalk code.  By default every non-TestInterpreterPlugin can simulate itself."

	^ self