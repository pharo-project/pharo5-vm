combination rules
pixClear: sourceWord with: destinationWord
	"Clear all pixels in destinationWord for which the pixels of sourceWord have the same values. Used to clear areas of some constant color to zero."
	| mask result nBits pv |
	<inline: false>
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	<var: #mask type: 'unsigned int'>
	<var: #pv type: 'unsigned int'>
	<var: #result type: 'unsigned int'>
	destDepth = 32 ifTrue:[
		sourceWord = destinationWord ifTrue:[^0] ifFalse:[^destinationWord].
	].
	nBits := destDepth.
	mask := maskTable at: nBits.  "partition mask starts at the right"
	result := 0.
	1 to: destPPW do:[:i |
		pv := destinationWord bitAnd: mask.
		(sourceWord bitAnd: mask) = pv ifTrue:[pv := 0].
		result := result bitOr: pv.
		mask := mask << nBits "slide left to next partition"].
	^ result