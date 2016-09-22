``launchimage``: Launch images
==============================

The ``forge.launchimage`` namespace allows you to customize the image to display while your app is loading.

By default, the launch image is hidden automatically when the window ``load`` event fires or after 5 seconds, whichever is sooner. This gives your JavaScript some time to
initialize itself, set up [native topbars](/modules/topbar/current/docs/index.html) and
[tabbars](/modules/tabbar/current/docs/index.html) for example. If you want full control over hiding the launch image yourself, set **Hide Manually** to `true` in the config.

##Config options

The majority of the configuration for the is paths to images at various resolutions. All launch images must be placed in your ``src`` directory. Paths to your launchimages should be specified relative to your `src` directory.


### iOS

> ::Note:: The old Launch Image schema and sizes are no longer supported by Apple.
>
> Instead of requiring a separate bitmap matching the resolution of each available iOS device Apple have introduced the notion of "size classes" which reduces the total number of images required to four.
>
> For more information on size classes, please read: [A Size Class Reference Guide](http://useyourloaf.com/blog/size-classes/)

wC_hC
:	Path to image for Compact width and Compact height size class. Used as the launch image on iPhone devices in landscape orientation. (Recommended size: 1334x750px)

wR_hC
:	Path to image for Regular width and Compact height size class. Used as the launch image on iPhone Plus devices in landscape orientation. (Recommended size: 1920x1080px)

wC_hR
:	Path to image for Compact width and Regular height size class. Used as the launch image on iPhone and iPhone Plus devices in portrait orientation. (Recommended size: 1080x1920px)

wR_hR
:	Path to image for Regular width and Regular height size class. Used as the launch image on iPad devices in both portrait and landscape orientation. (Recommended size: 2732x2048px)



### Android

Android, Android Landscape
:	Launchimages for Android devices.
	On Android the image will be displayed according to the **Background Size**
	configuration option. A **Background Size** value of ``"auto"`` will result
	in the image being displayed as centered while the first page is loading.
	As Android device sizes vary a pixel perfect loading image cannot be used.
	The image will be proportionally scaled down to fit the screen if necessary.
	A **Background Size** value of ``"cover"`` will result in the image
	being uniformly scaled by maintaining the image's aspect ratio so
	that both dimensions (width and height) of the image will be equal
	to or larger than the screen. The image is then centered in the view.
	The solid color to use behind this launch image can be configured with
	the **Background Color** configuration option.

> ::Note:: All images must be defined for a given platform in order to build successfully.

Background Color
:	The color to be shown behind the image if it doesn't fit the screen exactly, to be specified using
	a six digit hex color code - e.g. ``"#303045"``.

Background Size
:	Options for scaling the launch image which mimics the behaviour similar to the background-size
	property in CSS3. Options are ``"auto"`` or ``"cover"``.

Hide Manually
:	Setting this to `true` will prevent the automatic hiding of the launch image done by default,
	the launchimage will be hidden when you call [forge.launchimage.hide](index.html#forgelaunchimagehidesuccess-error).

> ::Note:: Use PNG format for all launch images, as it is required on at least iOS and your app
may not be submittable to the App Store otherwise.

##API

!method: forge.launchimage.hide(success, error)
!param: success `function(content)` called after the launch image has been hidden
!description: If you want to manually hide the launch image yourself, use this API.
!platforms: iOS, Android
!param: error `function(content)` called when the user chooses not to share their location with your app
