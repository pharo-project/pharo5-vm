java sources
generateJavaView
		self write: 'package org.smalltalk.stack;


import android.util.Log;

import org.smalltalk.stack.StackVM;
import org.smalltalk.stack.StackEvents;


import android.app.Activity;
import android.content.Context;
import android.graphics.Rect;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.util.DisplayMetrics;

import android.graphics.Bitmap.Config;

import android.graphics.Bitmap;

import android.view.View;
import android.view.MotionEvent;
import android.view.KeyEvent;

import android.os.Bundle;
import android.os.ResultReceiver;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.BaseInputConnection;
import android.view.inputmethod.InputMethodManager;

import java.util.Arrays;
import java.lang.System;

public class StackView extends View {
	StackVM vm;
	StackEvents eventManager;
	int bits[];	
	int width = 0;
	int height = 0;
	int depth = 32;
	int buttonBits;
	long timestamp = System.currentTimeMillis();
	int lastX = -1, lastY = -1, lastBut = -1;
	final int radius = 2;
	boolean softKbdOn;
	StackActivity ctx;
	Paint paint;

	private static final String TAG = "JAVA Smalltalk View";

	RR rr = new RR(this);

	/* Closure */
	private class RR extends ResultReceiver {
		StackView owner;
		public RR(StackView sv) {
			super(getHandler());
			owner = sv;
		}
		protected void  onReceiveResult  (int resultCode, Bundle resultData)
		{
			super.onReceiveResult(resultCode, resultData);
			switch(resultCode) {
				case InputMethodManager.RESULT_HIDDEN:
				case InputMethodManager.RESULT_UNCHANGED_HIDDEN:
					owner.softKbdOn = false;
					break;
				case InputMethodManager.RESULT_SHOWN:
				case InputMethodManager.RESULT_UNCHANGED_SHOWN:
					owner.softKbdOn = true;
					break;
				default:
			}
		}
	}


	public void showHideKbd(int what) {
		InputMethodManager imm = (InputMethodManager)
			ctx.getSystemService(Context.INPUT_METHOD_SERVICE);
		if (what == 1) {
			imm.showSoftInput(this, 0, rr);
		} else {
			imm.hideSoftInputFromWindow(this.getWindowToken(), 0);
		}
}

	public StackView(Context context,StackVM aVM) {
		super(context);
		this.vm = aVM;
		this.vm.setView(this);
		this.ctx = (StackActivity)context;
		this.paint = new Paint();
		this.eventManager = new StackEvents(this,vm);	
	}



	protected void onLayout(boolean changed, int left, int top, int right, int bottom)
	{
		Log.v(TAG,"onLayout" + changed + "  " + left + "  " + top + "  " + right + "  " + bottom);
		if(!changed) return;
		this.width = right - left;
		this.height = bottom - top;
		this.bits = new int[this.width * this.height];
		Arrays.fill(bits, 0);
		vm.setScreenSize(this.width, this.height);
	}


	public boolean onKeyUp(int keyCode, KeyEvent event) {
			return this.eventManager.onKeyUp(keyCode,event);
	}

	public boolean onKeyDown(int keyCode, KeyEvent event) {
			return this.eventManager.onKeyDown(keyCode,event);
	}

	public boolean onTouchEvent(MotionEvent event) {
			return this.eventManager.onTouchEvent(event);
	}
		
	/**
     * Render me
     * 
     * @see android.view.View#onDraw(android.graphics.Canvas)
     */
    @Override
    protected void onDraw(Canvas canvas) {
		
		
	if (bits == null) return;
    	Rect dirtyRect = new Rect(0,0,0,0);
    	if(canvas.getClipBounds(dirtyRect)) {
    		vm.updateDisplay(bits, width, height, depth, 
				dirtyRect.left, dirtyRect.top, dirtyRect.right, dirtyRect.bottom);
    	}
        super.onDraw(canvas);
        canvas.drawColor(-1);
		Bitmap theRenderingWorld = Bitmap.createBitmap(bits,width,height,Bitmap.Config.valueOf("ARGB_8888"));
		canvas.drawBitmap(theRenderingWorld, 0, 0 , paint);
		if(vm.updatingViewProcessIsActive()) this.postDelayed(new StackReativate(), 100);
		
    }  
	
	final class StackReativate implements Runnable {
		public void run() {
			Log.v(TAG,"StackReativate");
			StackView.this.vm.reenterFromDisplays();
		}
	}
	
	
	  
    /**
     * Text Input handling
     */
    @Override
    public boolean onCheckIsTextEditor() {
    	return true;
    }
    
    @Override
    public InputConnection onCreateInputConnection(EditorInfo outAttrs) {
    	if(!onCheckIsTextEditor()) return null;
    	return new BaseInputConnection(this, false);
    }
    
}
' 
toFile: 'src/org/smalltalk/stack/StackView.java'