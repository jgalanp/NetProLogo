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

## Important notes

Before using the extension make sure you have installed the proper NetLogo and SWI-Prolog versions. In this [link](http://www.swi-prolog.org/download/stable?show=all) you can find different SWI-Prolog versions.

##### Version compatibility

* NetProLogo was developed for NetLogo 5.x
* NetPrologo is compatible with SWI-Prolog 6.6.x and earlier versions. Note that the new SWI-Prolog 7.x is not supported yet.

##### Windows users

* Make sure you install a 32 bits SWI-Prolog. 64 bits version is not compatible since NetLogo uses a 32 bits JVM.

##### Mac users

* Application bundle is not supported (SWI-Prolog 6.6x). You can install SWI-Prolog 6.6.x using [Macports](http://www.swi-prolog.org/build/macos.html) or use [SWI-Prolog installers](http://www.swi-prolog.org/download/stable?show=all) for versions 6.4.x and earlier. The reason is that the extension needs SWI-Prolog to be installed in system's root and not in Mac OS Applications folder.

##### Linux Users

* Note that some SWI-Prolog packages for Linux comes without the JPL library. In this case you can install it separately.
  * In many Linux repositopries this library is called *swi-prolog-java* (alternatively it could be swi-prolog-jpl).
  * To can discover if you have this library installed by looking, within your SWI-Prolog installation, for the files *jpl.jar* and *libjpl.so*.
    * The default paths of these files for SWI-Prolog 6.4.x in Ubuntu Trusty (14.04 LTS) are:
        * */usr/lib/swi-prolog/lib/amd64/libjpl.so*
        * */usr/lib/swi-prolog/lib/jpl.jar*

## Installation
