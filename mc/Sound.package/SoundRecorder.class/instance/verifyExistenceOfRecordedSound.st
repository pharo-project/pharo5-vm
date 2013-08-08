recording controls
verifyExistenceOfRecordedSound
 	"If the receiver has a recorded sound, answer true; if not, put up an informer and answer false"
 
 	^ self recordedSound
 		ifNotNil:
 			[true]
 		ifNil:
 			[self inform: 'please record a sound first' translated.
 			false]