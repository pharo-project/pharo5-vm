"the bae configuration for loading VMMaker can be found under
../codegen-scripts/LoadVMMaker.st"


"Only load this startup script in interactive mode"
Smalltalk isInteractive ifTrue: [

"Open workspace with example Configurations"
Workspace openContents: (String streamContents: [ :stream|
        stream << '"Configuration for the Pharo VM ---------------------------------------------------"'; cr.
		stream << 'PharoVMBuilder '; cr.
		stream << '	buildUnix32.'; cr; cr.
		
		stream << 'PharoVMBuilder '; cr.
		stream << '	buildMacOSX32.'; cr; cr.

		stream << 'PharoVMBuilder '; cr.
		stream << '	buildWin32.'; cr; cr.
		
        stream << '"Configuration for the PharoS VM ---------------------------------------------------"'; cr.
		stream << 'PharoSVMBuilder '; cr.
		stream << '	buildUnix32.'; cr; cr.
		
		stream << 'PharoSVMBuilder '; cr.
		stream << '	buildMacOSX32.'; cr; cr.

		stream << 'PharoSVMBuilder '; cr.
		stream << '	buildWin32.'; cr; cr.

        stream << '"For more details see the internals of PharoVMBuilder and PharoSVMBuilder"'; cr.
    ]).
]