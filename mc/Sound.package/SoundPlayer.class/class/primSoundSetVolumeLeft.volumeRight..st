private
primSoundSetVolumeLeft: aLeftVolume volumeRight: aRightVolume
	"Set sound pass in float 0.0-1.0 for left and right channel, with possible 2.0 or  higher to overdrive sound channel "
	<primitive: 'primitiveSoundSetLeftVolume' module: 'SoundPlugin'>
