java sources
generateJavaVM
		self write: 'package org.smalltalk.stack;
import android.content.res.AssetManager;
import java.lang.Exception;
import java.io.File;
import java.io.InputStream;
import java.io.FileInputStream;

import java.util.Locale;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import android.util.Log;

import org.smalltalk.stack.StackActivity;
import org.smalltalk.stack.StackView;

import android.os.Environment;
import android.content.Context;
import android.text.ClipboardManager;
import android.app.NotificationManager;
import android.speech.tts.TextToSpeech;
import android.graphics.Bitmap;

import android.content.Intent;
import android.net.Uri;


public class StackVM {
	StackActivity context;
	StackView view;
	boolean updateProcessSentinelle;
	File imageDir;
	TextToSpeech mTts = null;
	float pitch = 1.0f;
	float rate = 1.0f;
	
	
	public StackVM(StackActivity ctx){
		this.context = ctx;		
	}
	
	public void setView(StackView aView){
		this.view = aView;
	}
	

	private static final String TAG = "JAVA Smalltalk VM";

/* Open the given string in a browser (broadcast an URI intent) */

    int openURI(String url) {
	final Intent intent = new Intent(Intent.ACTION_VIEW).setData(Uri.parse(url));
	context.startActivity(intent);
	return 0;
    }


/* Finish the whole activity */

    public void finish() {
	Log.v(TAG, "Stack VM finishing");
	context.finish();
       	String ns = Context.NOTIFICATION_SERVICE;
        NotificationManager notmgr = (NotificationManager) context.getSystemService(ns);
	if(notmgr != null) notmgr.cancelAll();
	//surelyExit();
    }

/* Helper method to place a shortcut icon on the home screen for the given image */

    public void imageShortCut(String imagePath,              // path to the image (not checked)
		              String label,                  // shortcut label
			      String cmd,                    // command to run with image (rsvd)
			      int icnwh,                     // icon bitmap width<<16 | height in px
			      int icnflg,                    // shortcut flags (rsvd)
			      byte icnbits[])                // icon bits (ARGB_8888)
    {

        // Intent to be placed on the shortcut

	Intent sci = new Intent();
	sci.setAction(Intent.ACTION_VIEW);
	Uri uri = new Uri.Builder().scheme("file").path(imagePath).build();
	sci.setDataAndType(uri, "application/x-squeak-image");
	sci.putExtra("command", cmd);
	
	// Intent to create the shortcut. If bitmap address is 0 then use a generic icon
	// from resources. Otherwise build a bitmap.

        Intent addIntent = new Intent();
	addIntent.putExtra(Intent.EXTRA_SHORTCUT_INTENT, sci);
	addIntent.putExtra(Intent.EXTRA_SHORTCUT_NAME, label);
	if(icnbits == null) {
	    addIntent.putExtra(Intent.EXTRA_SHORTCUT_ICON_RESOURCE, 
			Intent.ShortcutIconResource.fromContext(context, R.drawable.smalltalk));
	} else {
	    int i, j;
	    int colors[] = new int[1 + icnbits.length / 4];
	    for(i = j = 0; i < icnbits.length; i++) {
		int m = i % 4;
		if(m == 0) colors[j] = 0;
		switch(i % 4) {
		    case 0:
			colors[j] |= ((icnbits[i] << 24) & 0xFF000000);
			break;
		    case 1:
			colors[j] |= ((icnbits[i] << 16) & 0x00FF0000);
			break;
		    case 2:
			colors[j] |= ((icnbits[i] << 8) & 0x0000FF00);
			break;
		    case 3:
			colors[j] |= (icnbits[i] & 0x00FF);
			j++;
		        break;
		    default:
			;
		}
	    }
	    Bitmap bmp = Bitmap.createBitmap(colors, 
			    (icnwh >> 16) & 0xFFFF, icnwh & 0xFFFF, Bitmap.Config.ARGB_8888);
            Bitmap scaled = Bitmap.createScaledBitmap(bmp, 48, 48, true);
	    addIntent.putExtra(Intent.EXTRA_SHORTCUT_ICON, scaled);
	}
	addIntent.setAction("com.android.launcher.action.INSTALL_SHORTCUT");
	context.sendBroadcast(addIntent);


    }


    public int loadImage(String executablePath, String imageName, String cmd) {
	        String imgpath = imageName;
	        File imgfile = new File(imgpath);
	        long fsize = imgfile.length();
	    	int why = 0;
			Log.v(TAG, "loadImage: ");
			why = this.setVMPath(executablePath ,imageName, cmd);
			if (why == 3) this.updateDisplayProcess();
			return why;
		   
    }
   
    /* VM callbacks */
    public void invalidate(int left, int top, int right, int bottom) {
    	 Log.v(TAG, "invalidate ");
		view.invalidate(left, top, right, bottom);
    }

    /* Show/hide soft keyboard: needed by a Smalltalk primitive */

    public void showHideKbd(int what) {
    }

    /* Display a brief message (toast) - to be called by the fer */

    public void briefMessage(String s) {
    }
	

    /* Obtain a string of text from Android clipboard, if available */

    public String getClipboardString() {
	ClipboardManager cmgr = 
	    (ClipboardManager) context.getSystemService(Context.CLIPBOARD_SERVICE);
	if (cmgr == null) return "";
	CharSequence paste = cmgr.getText();
	String ptxt = (paste != null)?paste.toString():"";
	return ptxt;
    }

    /* Obtain the time format per current locale */

    public String getTimeFormat(int longfmt) {
	Locale loc = Locale.getDefault();
	int jlfmt = 
	    (longfmt == 1)?java.text.SimpleDateFormat.LONG:java.text.SimpleDateFormat.SHORT;
        SimpleDateFormat sdf = 
	    (SimpleDateFormat)SimpleDateFormat.getTimeInstance(jlfmt, loc);
	return sdf.toLocalizedPattern();
    }

    /* Obtain the date format per current locale */

    public String getDateFormat(int longfmt) {
	Locale loc = Locale.getDefault();
	int jlfmt = 
	    (longfmt == 1)?java.text.SimpleDateFormat.LONG:java.text.SimpleDateFormat.SHORT;
        SimpleDateFormat sdf = 
	    (SimpleDateFormat)SimpleDateFormat.getDateInstance(jlfmt, loc);
	return sdf.toLocalizedPattern();
    }

    /* Obtain the current/default Locale string */

    public String getLocaleString() {
	Locale loc = Locale.getDefault();
	return loc.toString();
    }

    /* Obtain the thousand and decimal separators per current locale */

    public String getSeparators() {
	Locale loc = Locale.getDefault();
	DecimalFormatSymbols dfs = new DecimalFormatSymbols(loc);
	char dec = dfs.getDecimalSeparator();
	char thou = dfs.getGroupingSeparator();
	return new String(new char[] {dec, thou});
    }

    /* Obtain the currency symbol per current locale */

    public String getCurrencySymbol() {
	Locale loc = Locale.getDefault();
	DecimalFormatSymbols dfs = new DecimalFormatSymbols(loc);
	return dfs.getCurrencySymbol();
    }

    /* Set VM idle timer interval */

    public void setVMTimerInterval(int d) {
	//if (view != null) view.setTimerDelay(d);
    }

    /* Get VM idle timer interval */

    public int getVMTimerInterval() {
	//if (view != null) returwwwn view.getTimerDelay();
	//else return -1;
    return 1;
	}
	
	
  	public int sendKeyboardEventToVM( int arg3, int arg4, int arg5, int arg6){
    	int why = 0;
		Log.v(TAG, "sendKeyboardEventToVM: " + arg3 + "  "+ arg4 + "  " + arg5 + "  " + arg6);
		why = this.sendKeyboardEvent(arg3,arg4,arg5,arg6);
		if (why == 3) this.updateDisplayProcess();
		return why;
    }
	
	public int sendTouchEventToVM(int arg3, int arg4, int arg5){
    	int why = 0;
		Log.v(TAG, "sendTouchEventToVM: " + arg3 + "  "+ arg4 + "  " + arg5);
		why = this.sendTouchEvent(arg3,arg4,arg5);
		if (why == 3) this.updateDisplayProcess();
		return why;
	}
	
	public void updateDisplayProcess(){
			view.invalidate();
			updateProcessSentinelle = true;
	}
	
	
	public boolean updatingViewProcessIsActive(){
		return updateProcessSentinelle;
	}
	
	public int reenterFromDisplays(){
		int why = 0;
		why = this.runVM();
		if (why == 3) this.updateDisplayProcess();
		return why;
	}

    /* Get SD card root directory */

    public String getSDCardRoot() {
	return Environment.getExternalStorageDirectory().getAbsolutePath();
    }

    /* Main entry points */
    public native int setScreenSize(int w, int h);
    public native int setVMPath(String exeName, String imageName, String cmd);
    private native int sendKeyboardEvent( int arg3, int arg4, int arg5, int arg6);
	private native int sendTouchEvent(int arg3, int arg4, int arg5);
  	public native int updateDisplay(int bits[], int w, int h, int d, int l, int t, int r, int b);
	private native int runVM();
  	
	/* Load the StackVM module */
    static {
		
		System.loadLibrary("vm-display-android");
		// System.loadLibrary("vm-display-null");
		System.loadLibrary("vm-sound-null");
    		System.loadLibrary("VirtualMachine");
    }
}
' 
toFile: 'src/org/smalltalk/stack/StackVM.java'