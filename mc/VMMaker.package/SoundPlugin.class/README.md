This plugin implements the main sound related primiives.  Since it requires platform support it will only be built when supported on your platform


FORMAT OF SOUND DATA

Squeak uses 16-bit signed samples encoded in the host's endian order.  A sound buffer is a sequence of "frames", or "slices", where each frame usually includes one sample per channel.  The exception is that for playback, each frame always includes 2 samples; for monaural playback, every other sample is ignored.
