package io.trigger.forge.android.modules.launchimage;

import io.trigger.forge.android.core.ForgeApp;
import io.trigger.forge.android.core.ForgeEventListener;
import android.os.Bundle;

public class EventListener extends ForgeEventListener {
	@Override
	public void onCreate(Bundle savedInstanceState) {
		Util.showLaunchImage(ForgeApp.getActivity());
	}
	@Override
	protected void onReloadUpdateApply() {
		Util.showLaunchImage(ForgeApp.getActivity());
	}
}
