cmake commands
set: variableName toString: aValueString

	^ self set: variableName to: '"', (aValueString copyReplaceAll: '"' with: '\"'), '"'