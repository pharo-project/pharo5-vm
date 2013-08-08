I am a queue for sound - give me a bunch of sounds to play and I will play them one at a time in the order that they are received.

Example:
"Here is a simple example which plays two sounds three times."
| clink warble queue |
clink := SampledSound soundNamed: 'clink'.
warble := SampledSound soundNamed: 'warble'.
queue := QueueSound new.
3 timesRepeat:[
	queue add: clink; add: warble
].
queue play.

Structure:
 startTime 		Integer -- if present, start playing when startTime <= Time millisecondClockValue
							(schedule the sound to play later)
 sounds			SharedQueue -- the synchronized list of sounds.
 currentSound	AbstractSound -- the currently active sound
 done			Boolean -- am I done playing ?

Other:
You may want to keep track of the queue's position so that you can feed it at an appropriate rate. To do this in an event driven way, modify or subclass nextSound to notify you when appropriate. You could also poll by checking currentSound, but this is not recommended for most applications.

