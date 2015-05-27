# NetProLogo
NetProLogo ([NetLogo](https://ccl.northwestern.edu/netlogo/) + [Prolog](http://en.wikipedia.org/wiki/Prolog)) is a [NetLogo](https://ccl.northwestern.edu/netlogo/) extension that allows running [Prolog](http://en.wikipedia.org/wiki/Prolog) code inside [NetLogo](https://ccl.northwestern.edu/netlogo/) in order to take advantage of [Prolog](http://en.wikipedia.org/wiki/Prolog) features to provide [NetLogo](https://ccl.northwestern.edu/netlogo/) agents  (turtles, links and patches... or the observer) with reasoning capabilities.

There exist two major NetProLogo versions depending on the [Prolog](http://en.wikipedia.org/wiki/Prolog) engine they use:

##### NetProLogo for SWI-Prolog

This is the NetPrologo version currently active. We have changed to [SWI-Prolog](http://www.swi-prolog.org/) since it is the most widely used [Prolog](http://en.wikipedia.org/wiki/Prolog) engine and it supports most of the existing [Prolog](http://en.wikipedia.org/wiki/Prolog) code and extensions. However this NetProLogo version presents two drawbacks with respect to the former one:

* The extension allows having only one open [Prolog](http://en.wikipedia.org/wiki/Prolog) call at once. The former version of the extension allowed having multiple instances of the [Prolog](http://en.wikipedia.org/wiki/Prolog) engine running simultaneously.
* The installation of the extension is OS dependent as it relies the [SWI-Prolog](http://www.swi-prolog.org/) installed on the system.

##### NetProLogo for GPJ (GNU Prolog for Java)

This is a NetProLogo old version which is not being maintained anymore. However it is still available in this [site](http://www.cs.us.es/~fsancho/NetProLogo/). This version of the extension was ruled since [GPJ](http://www.gnu.org/software/gnuprologjava/gnuprologjava.html) supports only basic [Prolog](http://en.wikipedia.org/wiki/Prolog) sintax, therefore it was not compatible with most of the existing [Prolog](http://en.wikipedia.org/wiki/Prolog) code and extensions. Moreover its development was discontinued. The advantages of using this extension are:

* Cross-platform compatibility. [GPJ](http://www.gnu.org/software/gnuprologjava/gnuprologjava.html) was entirely devoloped in Java.
* Supports running multiple instances of the [Prolog](http://en.wikipedia.org/wiki/Prolog) engine simultaneously, which can be very useful in multi-agent programming since it allows each agent having its own reasoner and knowledge base.

## Installation
