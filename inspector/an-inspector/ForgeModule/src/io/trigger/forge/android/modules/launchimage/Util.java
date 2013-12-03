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
import android.widget.RelativeLayout;

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
		
		ImageView splashImage = new ImageView(activity);
		RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
		params.addRule(RelativeLayout.CENTER_IN_PARENT);
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
