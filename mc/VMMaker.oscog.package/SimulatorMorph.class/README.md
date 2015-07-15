A SimulatorMorph is a copy of PreferenceBrowserMorph that has been mangled into something that will support the simulator.  I provide some UI features inspired by Bert Freudenberg's Lively Squeak VM at http://lively-web.org/users/bert/squeak.html.

See class protocol 'documentation' for examples of invoking me.

My model is SimulatorMorphicModel. 
My model has a reference to the Simulator and itermediates all (?) interaction with it.

The simulator renders the simulated World on a SimulatorImageMorph that I contain. 

There is some cruft (tight coupling via direct references along all three layers UI-Model-VM) in me that exists to support Eliot's original Simulator>>openAsMorph functionality and use-case.
Rumors that said cruft is an artifact of tty's rudimentary Morphic skills are entirely credible.

I hold out the barest glimmer of hope that Bert Freudenberg's SqueakJS functionality can be integrated into my functionality as well. 
see http://lively-web.org/users/bert/squeak.html for the inspiration.

I am not amenable to Flaps or the WorldMenu as there is a lot of pre-run configuration that is done to the Simulator prior to its being run.
Managing that ability with a GUI is counter-productive. If said functionality is desired in the future, then inspiration can be gleaned by cut-n-paste from PreferenceBrowser and PreferenceBrowserModel.