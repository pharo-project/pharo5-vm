window construction
buildCenterRows
	| rows color1 color2 |
	color1 := Color blue veryMuchLighter.
	color2 := Color green veryMuchLighter.
	rows := Morph new color: Color transparent;
				layoutPolicy: TableLayout new;
				vResizing: #spaceFill;
				extent: 550 @ (TextStyle defaultFont height * 14);
				hResizing: #spaceFill;
				listDirection: #topToBottom;
				borderStyle: (BorderStyle complexAltRaised width: 2);
				wrapDirection: #none;
				wrapCentering: #center;
				yourself.
	rows
		addMorphBack: ((self
				entryRowWithLabel: 'Interpreter class name:'
				balloonText: 'The name of the Interpreter class'
				getFieldText: #interpreterClassName
				setFieldText: #interpreterClassName:
				buttonLabel: nil
				buttonAction: nil
				buttonBalloonText: nil)
				color: color1).
	interpreterClassMorph := rows submorphs last submorphs first.

	rows
		addMorphBack: ((self
				entryRowWithLabel: 'Path to platforms code:'
				balloonText: 'The directory where the platform source tree is found; can be edited in text field to the right. Default of {working directory}/src is strongly recommended'
				getFieldText: #platformsPathText
				setFieldText: #platformsPathText:
				buttonLabel: 'Find Path'
				buttonAction: #findPlatformsPath
				buttonBalloonText: 'Choose the directory where you keep the platform specific code from a file dialogue')
				color: color2).
	platformPathMorph := rows submorphs last submorphs second.

	rows
		addMorphBack: ((self
				entryRowWithLabel: 'Platform name:'
				balloonText: 'The platform name (as returned by Smalltalk platformName - unix, Mac OS, RISCOS, win32 etc); can be edited (in text field to the right) to cross generate'
				getFieldText: #platformNameText
				setFieldText: #platformNameText:
				buttonLabel: 'Find platform'
				buttonAction: #platformsListMenu
				buttonBalloonText: 'Choose from a list of known platforms. The default is this current platform.')
				color: color1).
	platformNameMorph := rows submorphs last submorphs second.

	rows
		addMorphBack: ((self
				entryRowWithLabel: 'Path to generated sources'
				balloonText: 'The directory where the built sources will be placed; can be edited in text field to the right. The default is strongly recommended; makefile alterations may be needed if you use a different path.'
				getFieldText: #sourcePathText
				setFieldText: #sourcePathText:
				buttonLabel: 'Clean out'
				buttonAction: #cleanoutSrcDir
				buttonBalloonText: 'Clean out all the files in the target directory, ready for a clean build')
				color: color2).
	generatedPathMorph := rows submorphs last submorphs second.

	^ rows