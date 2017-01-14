A SimulatorMorphicModel handles Morphic callbacks and UI  for (some parts of ) the simulator.

I   handle event forwarding management..

Currently, I am a listener to HandMorphs>>addPrimitiveEventListener. 
I am added as a listener by SimulatorMorph>>displayView (which probably  needs to change. tty)