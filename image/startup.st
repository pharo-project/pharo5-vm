"the bae configuration for loading VMMaker can be found under
../codegen-scripts/LoadVMMaker.st"


"Only load this startup script in interactive mode"
Smalltalk isInteractive ifTrue: [

"Open workspace with example Configurations"

GTPlayground 
	openContents: (String streamContents: [ :stream |
		stream 
			<< '"Configuration for the Pharo VM'; cr;
			<< ' ------------------------------"'; cr;
			<< 'PharoVMBuilder buildUnix32.'; cr;
			<< 'PharoVMBuilder buildMacOSX32.'; cr;
			<< 'PharoVMBuilder buildWin32.'; cr; 
			cr.
		
		stream 
			<< '"Configuration for the PharoS VM'; cr;
			<< ' -------------------------------"'; cr;
			<< 'PharoSVMBuilder buildUnix32.'; cr; 
			<< 'PharoSVMBuilder buildMacOSX32.'; cr;
			<< 'PharoSVMBuilder buildWin32.'; cr; 
			cr.

		stream 
			<< '"For more details see the internals of PharoVMBuilder and PharoSVMBuilder"'; cr.
    ])
	label: 'Building VM'.
]