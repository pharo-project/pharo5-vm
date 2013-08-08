translation
isResponsibleForThisPlatform
	"Answer true is this is an instance of the class which is responsible for representing
	the OS process for the Squeak VM running on the current platform. A false answer is
	usually the result of running the image on a different platform and VM.
	Note: Keep this method is sync with OSProcess>>isUnix."

	| numericOsVersion |

	^ (self platformName = 'unix') or:
		[numericOsVersion := self osVersion asInteger ifNil: [0].
		(self platformName = 'Mac OS') and: [numericOsVersion >= 1000]]
