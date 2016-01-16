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
			<< 'PharoVMSpur32Builder buildUnix32.'; cr;
			<< 'PharoVMSpur32Builder buildMacOSX32.'; cr;
			<< 'PharoVMSpur32Builder buildWin32.'; cr;
			cr.
		
		stream 
			<< '"Configuration for the PharoS VM'; cr;
			<< ' -------------------------------"'; cr;
			<< 'PharoSVMSpur32Builder buildUnix32.'; cr;
			<< 'PharoSVMSpur32Builder buildMacOSX32.'; cr;
			<< 'PharoSVMSpur32Builder buildWin32.'; cr;
			cr.

		stream 
			<< '"For more details see the internals of PharoVMSpur32Builder and PharoSVMSpur32Builder"'; cr.
    ])
	label: 'Building VM'.
]
