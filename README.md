# NetProLogo
NetProLogo (NetLogo + [Prolog](http://en.wikipedia.org/wiki/Prolog)) is a NetLogo extension that allows running Prolog code inside NetLogo in order to take advantage of [Prolog](http://en.wikipedia.org/wiki/Prolog) features to provide NetLogo agents  (turtles, links and patches... or the observer) with reasoning capabilities.

There exist two major NetProLogo versions depending on the [Prolog](http://en.wikipedia.org/wiki/Prolog) engine they use:

###### NetProLogo for SWI-Prolog

This is the NetPrologo version currently active. We have changed to [SWI-Prolog](http://www.swi-prolog.org/) since it is the most widely used [Prolog](http://en.wikipedia.org/wiki/Prolog) engine and it supports most of the existing [Prolog](http://en.wikipedia.org/wiki/Prolog) code and extensions. However this NetProLogo version presents two drawbacks with respect to the former one:

* The extension allows having only one open [Prolog](http://en.wikipedia.org/wiki/Prolog) call at once. The former version of the extension allowed having multiple instances of the [Prolog](http://en.wikipedia.org/wiki/Prolog) engine running simultaneously.
* The installation of the extension is OS dependent as it relies the [SWI-Prolog](http://www.swi-prolog.org/) installed on the system.

###### NetProLogo for GPJ (GNU Prolog for Java)

- GNU Prolog for Java based (the old one)

