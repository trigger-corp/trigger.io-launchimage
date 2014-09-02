module("forge.launchimages");

if (forge.is.mobile()) {
	asyncTest("Right launch image displayed", 1, function() {
		askQuestion("Was the launch image bright green (on a red background on Android)?", {
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
}
