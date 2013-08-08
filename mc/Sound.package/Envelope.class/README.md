An envelope models a three-stage progression for a musical note: attack, sustain, decay. Envelopes can either return the envelope value at a given time or can update some target object using a client-specified message selector.

The points instance variable holds an array of (time, value) points, where the times are in milliseconds. The points array must contain at least two points. The time coordinate of the first point must be zero and the time coordinates of subsequent points must be in ascending order, although the spacing between them is arbitrary. Envelope values between points are computed by linear interpolation.

The scale slot is initially set so that the peak of envelope matches some note attribute, such as its loudness. When entering the decay phase, the scale is adjusted so that the decay begins from the envelope's current value. This avoids a potential sharp transient when entering the decay phase.

The loopStartIndex and loopEndIndex slots contain the indices of points in the points array; if they are equal, then the envelope holds a constant value for the sustain phase of the note. Otherwise, envelope values are computed by repeatedly looping between these two points.

The loopEndMSecs slot can be set in advance (as when playing a score) or dynamically (as when responding to interactive inputs from a MIDI keyboard). In the latter case, the value of scale is adjusted to start the decay phase with the current envelope value. Thus, if a note ends before its attack is complete, the decay phase is started immediately (i.e., the attack phase is never completed).

For best results, amplitude envelopes should start and end with zero values. Otherwise, the sharp transient at the beginning or end of the note may cause audible clicks or static. For envelopes on other parameters, this may not be necessary.
