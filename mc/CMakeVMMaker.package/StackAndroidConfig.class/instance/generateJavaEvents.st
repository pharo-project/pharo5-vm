java sources
generateJavaEvents
		self write: 'package org.smalltalk.stack;

import android.util.Log;
import org.smalltalk.stack.StackVM;
import org.smalltalk.stack.StackView;
import android.app.Activity;
import android.content.Context;

import android.view.MotionEvent;
import android.view.KeyEvent;



public class StackEvents  {
	StackVM vm;
	StackView view;
	int bits[];
	int width;
	int height;
	int depth;
	int buttonBits;
	long timestamp = System.currentTimeMillis();
	int lastX = -1, lastY = -1, lastBut = -1;
	final int LEFT_BUTTON_BIT = 4;
	final int MIDDLE_BUTTON_BIT = 2;
	final int RIGHT_BUTTON_BIT = 1;
	final int radius = 2;
	boolean softKbdOn;
	int ctrlOn, shiftOn;
	int timerDelay;

	private static final String TAG = "JAVA Smalltalk Events";
	
	public StackEvents(StackView aView, StackVM aVM) {
		
		this.vm = aVM;
		this.view = aView;
		softKbdOn = false;
		ctrlOn = 0;
		shiftOn = 0;
		bits = null;
		buttonBits = LEFT_BUTTON_BIT;
    	
		
		
	}
	
	public int getTimerDelay() {
	    return timerDelay;
	}


	public void setTimerDelay(int d) {
            timerDelay = d;
	}



    public boolean onKeyUp(int keyCode, KeyEvent event) {
		switch(keyCode) {
			case 59:
			case 60:
				shiftOn = 0;
				break;
			case 126:
			case 127:
				ctrlOn = 0;
				break;
			default:
				break;
		}
		return true;
	}

	public boolean onKeyDown(int keyCode, KeyEvent event) {
		int rc = 0;
		switch(keyCode) {
			case 59:
			case 60:
				shiftOn = 1;
				return true;
			case 126:
			case 127:
				ctrlOn = 1;
				return true;
			case KeyEvent.KEYCODE_BACK:
				switch(buttonBits)
				{
				    case MIDDLE_BUTTON_BIT:
				        buttonBits = RIGHT_BUTTON_BIT;
					break;
				    default:
				        buttonBits = MIDDLE_BUTTON_BIT;
					break;
				}
				return true;
			case 92: //KeyEvent.KEYCODE_PAGE_UP:
				buttonBits = RIGHT_BUTTON_BIT;
				return true;
			case KeyEvent.KEYCODE_MENU:
				return true;
			case 78: // received for Home and End, but scancodes are different
				switch(event.getScanCode()) {
					case 102:	// Home
						emulate(1);
						//rc = vm.relaunchInterpretation();
						break;
					case 107:	// End
						emulate(4);
						//rc = vm.relaunchInterpretation();
						break;
					default:
						rc = 0;
						break;
				}
				break;
			case KeyEvent.KEYCODE_ENTER:      // special handling for Enter: send ^M
				vm.sendKeyboardEventToVM(13 /* charCode */,
						0 /* EventKeyChar */,
						0 /* modifiers */,
						13 /* utf32Code */);
				break;
			case KeyEvent.KEYCODE_DPAD_RIGHT: // special handling for right arrow
				emulate(29);
				//rc = vm.relaunchInterpretation();
				break;
			case KeyEvent.KEYCODE_DPAD_LEFT: // special handling for left arrow
				emulate(28);
				//rc = vm.relaunchInterpretation();
				break;
			case KeyEvent.KEYCODE_DPAD_UP: // special handling for up arrow
				emulate(30, (event.getScanCode() == 0) ? 2 : 0); // 2 for wheel
				//rc = vm.relaunchInterpretation();
				break;
			case KeyEvent.KEYCODE_DPAD_DOWN: // special handling for down arrow
				emulate(31, (event.getScanCode() == 0) ? 2 : 0); // 2 for wheel
				//rc = vm.relaunchInterpretation();
				break;
			case KeyEvent.KEYCODE_DEL: // special handling for DEL
				emulate(8);
				//rc = vm.relaunchInterpretation();
				break;
			default:		 // send key event
				int uchar = (keyCode != -1)?
					event.getUnicodeChar():
					event.getCharacters().codePointAt(0);
				if (uchar == 0) return false;
				int mod = (ctrlOn > 0) ? 2 : 0;
				if (ctrlOn > 0) uchar = uchar & 0x1F;
				vm.sendKeyboardEventToVM(
						uchar /* charCode */,
						0 /* EventKeyChar */,
						mod /* modifiers */,
						uchar /* utf32Code */);
		}
		return true;
	}

	// Touch the screen and possibly move while pressing. Current button bits
	// will be used until the pressure removed, i. e. forward/back button modifiers
	// last exactly for one touch (or click).

	public boolean onTouchEvent(MotionEvent event) {
		int buttons = 0;
		int ex = (int)event.getX();
		int ey = (int)event.getY();
		int motionAction = event.getAction();
		int pointerCount = event.getPointerCount();
		boolean inMove = false;
		boolean shouldSend = false;
		Log.v(TAG, "Pointer count " + pointerCount);
		shouldSend = true;
		switch (motionAction & MotionEvent.ACTION_MASK) {
			case MotionEvent.ACTION_POINTER_DOWN:
			case MotionEvent.ACTION_DOWN: // 0
			if(buttons == 0) shouldSend = false;
			buttons = 0;
			switch(pointerCount){
				case 1: 
				buttonBits = LEFT_BUTTON_BIT;break;
				case 2:
				buttonBits = RIGHT_BUTTON_BIT;break;
			}
			break;
			
			case MotionEvent.ACTION_MOVE: // 2
				buttons = buttonBits;
				inMove = true;
				break;
				
			case MotionEvent.ACTION_UP: // 1
				if(inMove){
					buttons = 0;
					inMove = false;
				}
				else{
					buttons = buttonBits;
				}	
				break;
			default:
				Log.v(TAG, "Unsupported mtn. action: " + event.getAction());
			}
		if(shouldSend){
			vm.sendTouchEventToVM(ex, ey, buttons);
		}
		return true;
	}
	
	private void emulate(int keycode) {
		emulate(keycode, 0);
	}

	private void emulate(int keycode, int mods) {
		vm.sendKeyboardEventToVM(
				keycode /* charCode */,
				0 /* EventKeyChar */,
				mods | (shiftOn > 0 ? 1 : 0) /* modifiers */,
				keycode /* utf32Code */);
	}
	

}
' 
toFile: 'src/org/smalltalk/stack/StackEvents.java'