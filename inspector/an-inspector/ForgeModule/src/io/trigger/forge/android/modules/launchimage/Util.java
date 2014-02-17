package io.trigger.forge.android.modules.launchimage;

import io.trigger.forge.android.core.ForgeApp;
import io.trigger.forge.android.util.BitmapUtil;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.view.Display;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.ImageView.ScaleType;
import android.widget.RelativeLayout;

/**
 * Options for scaling the launch image.
 */
enum BackgroundSize {
	/**
     * Center the image in the view. 
	 * Perform no scaling if image is smaller than the screen else 
	 * the image will be proportionally scaled down to fit the screen
     */
	AUTO("auto"), 
	/**
     * Scale the image uniformly (maintain the image's aspect ratio) so
     * that both dimensions (width and height) of the image will be equal
     * to or larger than the corresponding dimension of the screen.
     * The image is then centered in the view.
     */
    COVER("cover");
    
    private final String value;

    private BackgroundSize(final String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    @Override
    public String toString() {
        return getValue();
    }
    
    public static BackgroundSize parseBackgroundSize(String backgroundSizeValue) {
    	if (backgroundSizeValue != null) {
    		for (BackgroundSize backgroundSize : BackgroundSize.values()) {
    			if (backgroundSizeValue.equalsIgnoreCase(backgroundSize.getValue())) {
    				return backgroundSize;
    			}
    		}
        }
    	return null;
   }
}

public class Util {
	private static Dialog launchImage = null;

	public static void showLaunchImage(Activity activity) {
		int theme = android.R.style.Theme_NoTitleBar;
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB_MR2) {
			theme = android.R.style.Theme_Holo_Light_NoActionBar;
		}
		launchImage = new Dialog(activity, theme);
		RelativeLayout layout = new RelativeLayout(activity);
		try {
			layout.setBackgroundColor(Color.parseColor(ForgeApp.configForPlugin("launchimage").get("background-color").getAsString()));
		} catch (Exception e) {
			layout.setBackgroundColor(Color.BLACK);
		}
		launchImage.setContentView(layout);
		launchImage.setCancelable(false);
		BackgroundSize backgroundSize = null;
		try {
			backgroundSize = BackgroundSize.parseBackgroundSize(ForgeApp.configForPlugin("launchimage").get("background-size").getAsString());
		} catch (Exception e) {
			// do nothing
		} finally {
			// background-size parse failure or unknown value provided, default to auto
			if (backgroundSize == null) {
				backgroundSize = BackgroundSize.AUTO;
			}
		}
		ImageView splashImage = new ImageView(activity);
		RelativeLayout.LayoutParams params = null;
		if (backgroundSize == BackgroundSize.COVER) {
			params = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT);
			splashImage.setScaleType(ScaleType.CENTER_CROP);
		} else {
			params = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
			params.addRule(RelativeLayout.CENTER_IN_PARENT);
		}
		splashImage.setLayoutParams(params);
		layout.addView(splashImage);
		try {
			Display display = ((WindowManager) activity.getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay();
			Drawable d = null;
			if (display.getWidth() < display.getHeight()) {
				d = BitmapUtil.drawableFromStream(activity, activity.getAssets().open(ForgeApp.configForModule("launchimage").get("android").getAsString()));
			} else {
				d = BitmapUtil.drawableFromStream(activity, activity.getAssets().open(ForgeApp.configForModule("launchimage").get("android-landscape").getAsString()));
			}
			splashImage.setImageDrawable(d);
		} catch (Exception e) {	
			// Splash screen image load failure - use default
			splashImage.setImageResource(ForgeApp.getResourceId("splash", "drawable"));
		}
		launchImage.show();
	}

	public static void hideLaunchImage() {
		if (launchImage != null) {
			launchImage.dismiss();
			launchImage = null;
		}
	}
}
