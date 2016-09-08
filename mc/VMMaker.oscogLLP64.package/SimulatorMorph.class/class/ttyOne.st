documentation
ttyOne
"Script tty uses to run the stackIntepreter using this class"
| vm |
Transcript clear.
vm := StackInterpreterSimulator newWithOptions: #(#STACKVM).
vm openOn: '/home/tty/usr/src/smalltalk/buildCogDevelopmentImageCog.app/Contents/Resources/targets/Squeak4.5.image'.
"vm setBreakSelector: #&."
vm 
	openAsSimulatorMorph "; 
	toggleTranscript;
	halt;
	run"
