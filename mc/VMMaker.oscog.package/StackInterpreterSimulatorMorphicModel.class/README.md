A StackInterpreterSimulatorMorphicModel handles Morphic callbacks and UI  for (some parts of ) the StackInterpreterSimulator.

I   handle event forwarding management..

Currently, I am a listener to HandMorphs>>addPrimitiveEventListener. 
I am added as a listener by StackInterpreterSimulatorMorph>>displayView (which probably  needs to change. tty)


instance vars:

stepping   when true the vm is running, but the user is stepping throught the stack--like a debugger. (not implemented: tty)


sharedPools: EventSensorConstants