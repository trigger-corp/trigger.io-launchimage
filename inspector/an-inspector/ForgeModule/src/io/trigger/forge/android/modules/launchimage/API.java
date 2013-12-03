package io.trigger.forge.android.modules.launchimage;

import io.trigger.forge.android.core.ForgeTask;

public class API {
	public static void hide(final ForgeTask task) {
		io.trigger.forge.android.modules.launchimage.Util.hideLaunchImage();
		task.success();
	}
}
