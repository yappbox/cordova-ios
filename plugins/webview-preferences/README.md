WebView Preferences
======

> The `WebViewPreferences` object provides some functions to customize the iOS Cordova WebView.

You can also set these preferences through config.xml during startup, see the Preferences section below.

Methods
-------

- WebViewPreferences.enableViewportScale
- WebViewPreferences.mediaPlaybackRequiresUserAction
- WebViewPreferences.mediaPlaybackAllowsAirPlay
- WebViewPreferences.allowInlineMediaPlayback
- WebViewPreferences.keyboardDisplayRequiresUserAction
- WebViewPreferences.suppressesIncrementalRendering
- WebViewPreferences.disallowOverscroll
- WebViewPreferences.gapBetweenPages
- WebViewPreferences.pageLength
- WebViewPreferences.paginationBreakingMode
- WebViewPreferences.paginationMode

Permissions
-----------

#### config.xml

            <feature name="WebViewPreferences">
                <param name="ios-package" value="CDVWebViewPreferences" onload="true" />
            </feature>


Preferences
-----------

#### config.xml

            <preference name="EnableViewportScale" value ="true" />
            <preference name="MediaPlaybackRequiresUserAction" value ="true" />
            <preference name="MediaPlaybackAllowsAirPlay" value ="true" />
            <preference name="AllowInlineMediaPlayback" value ="true" />
            <preference name="KeyboardDisplayRequiresUserAction" value ="false" />
            <preference name="SuppressesIncrementalRendering" value ="true" />
            <preference name="GapBetweenPages" value ="0" />
            <preference name="PageLength" value ="0" />
            <preference name="PaginationBreakingMode" value ="page" />
            <preference name="PaginationMode" value ="unpaginated" />


WebViewPreferences.enableViewportScale
=================

EnableViewportScale (boolean, defaults to false): Set to true to use a viewport meta tag to either disable or restrict the range of user scaling.

Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.enableViewportScale(true);
        WebViewPreferences.enableViewportScale(false);

WebViewPreferences.enableViewportScale
=================

EnableViewportScale (boolean, defaults to false): Set to true to use a viewport meta tag to either disable or restrict the range of user scaling.

Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.enableViewportScale(true);
        WebViewPreferences.enableViewportScale(false);

WebViewPreferences.mediaPlaybackRequiresUserAction
=================

MediaPlaybackRequiresUserAction (boolean, defaults to false): Set to true to prevent HTML5 videos from playing automatically with the autoplay attribute. Does not apply when calling play() on a video object.

Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.mediaPlaybackRequiresUserAction(true);
        WebViewPreferences.mediaPlaybackRequiresUserAction(false);

WebViewPreferences.mediaPlaybackAllowsAirPlay
=================

MediaPlaybackRequiresUserAction (boolean, defaults to true): A Boolean value that determines whether Air Play is allowed from this view.

Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.mediaPlaybackAllowsAirPlay(true);
        WebViewPreferences.mediaPlaybackAllowsAirPlay(false);

WebViewPreferences.allowInlineMediaPlayback
=================

AllowInlineMediaPlayback (boolean, defaults to false): Set to true to allow HTML5 media playback to appear inline within the screen layout, using browser-supplied controls rather than native controls. For this to work, add the **webkit-playsinline** attribute to any &lt;video&gt; elements.

Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.allowInlineMediaPlayback(true);
        WebViewPreferences.allowInlineMediaPlayback(false);

WebViewPreferences.keyboardDisplayRequiresUserAction
=================

KeyboardDisplayRequiresUserAction (boolean, defaults to true): Set to false to allow the keyboard to appear when calling **focus()** on form inputs.

Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.keyboardDisplayRequiresUserAction(true);
        WebViewPreferences.keyboardDisplayRequiresUserAction(false);

WebViewPreferences.suppressesIncrementalRendering
=================

SuppressesIncrementalRendering (boolean, defaults to false): Set to true to wait until all content has been received before it renders to the screen.

Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.suppressesIncrementalRendering(true);
        WebViewPreferences.suppressesIncrementalRendering(false);

WebViewPreferences.disallowOverscroll
=================

DisallowOverscroll (boolean, defaults to false): set to true if you don't want the WebView to rubber-band.

Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.disallowOverscroll(true);
        WebViewPreferences.disallowOverscroll(false);

WebViewPreferences.gapBetweenPages
=================

GapBetweenPages (float, defaults to 0): The size of the gap, in points, between pages.

Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.gapBetweenPages(0);
        WebViewPreferences.gapBetweenPages(4);

WebViewPreferences.pageLength
=================

PageLength (float, defaults to 0): The size of each page, in points, in the direction that the pages flow. When PaginationMode is **rightToLeft** or **leftToRight**, this property represents the width of each page. When PaginationMode is **topToBottom** or **bottomToTop**, this property represents the height of each page. The default value is 0, which means the layout uses the size of the viewport to determine the dimensions of the page.

Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.pageLength(0);
        WebViewPreferences.pageLength(95);

WebViewPreferences.paginationBreakingMode
=================

PaginationBreakingMode (string, defaults to page): The manner in which column- or page-breaking occurs. This property determines whether certain CSS properties regarding column- and page-breaking are honored or ignored. When this property is set to **column**, the content respects the CSS properties related to column-breaking in place of page-breaking.

Valid values are:

 * page
 * column

Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.paginationBreakingMode('page');
        WebViewPreferences.paginationBreakingMode('column');

WebViewPreferences.paginationMode
=================

PaginationMode (string, defaults to unpaginated): This property determines whether content in the web view is broken up into pages that fill the view one screen at a time, or shown as one long scrolling view. If set to a paginated form, this property toggles a paginated layout on the content, causing the web view to use the values of PageLength and GapBetweenPages to relayout its content.

Valid values are:

 * unpaginated
 * leftToRight
 * topToBottom
 * bottomToTop
 * rightToLeft
 
Supported Platforms
-------------------

- iOS

Quick Example
-------------

        WebViewPreferences.paginationMode('unpaginated');
        WebViewPreferences.paginationMode('leftToRight');
        WebViewPreferences.paginationMode('topToBottom');    
        WebViewPreferences.paginationMode('bottomToTop');
        WebViewPreferences.paginationMode('rightToLeft');
