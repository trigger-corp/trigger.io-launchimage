/* globals module, forge, asyncTest, askQuestion, ok, start */

module("forge.launchimages");

asyncTest("Right launch image displayed", 1, function() {
	askQuestion("Was the launch image bright green on a red background (Android) or describe itself correctly (iOS) ?", {
		Yes: function () {
			ok(true, "Success");
			start();
		},
		No: function () {
			ok(false, "User claims failure");
			start();
		}
	});
});
