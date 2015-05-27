# NetProLogo

NetProLogo ([NetLogo](http://en.wikipedia.org/wiki/NetLogo) + [Prolog](http://en.wikipedia.org/wiki/Prolog)) is a NetLogo extension that allows running Prolog code inside NetLogo in order to take advantage of Prolog features to provide NetLogo agents (turtles, links and patches... or the observer) with reasoning capabilities.

There exist two major NetProLogo versions depending on the Prolog engine they use:

##### NetProLogo for SWI-Prolog

This is the NetPrologo version currently active. We have changed to [SWI-Prolog](http://www.swi-prolog.org/) since it is the most widely used Prolog engine and it supports most of the existing Prolog code and extensions. This extension uses the [JPL](http://www.swi-prolog.org/packages/jpl/) library that comes with SWI-Prolog and provides a Java API to interact with it. However, this NetProLogo version presents two drawbacks with respect to the former one:

* The extension allows having only one open Prolog call at once. The former version of the extension allowed having multiple instances of the Prolog engine running simultaneously.
* The installation of the extension is OS dependent as it relies on the SWI-Prolog installed on the system.

##### NetProLogo for GPJ (GNU Prolog for Java)

This is a NetProLogo old version which is not being maintained anymore. However it is still available in this [site](http://www.cs.us.es/~fsancho/NetProLogo/). This version of the extension was ruled since [GPJ](http://www.gnu.org/software/gnuprologjava/gnuprologjava.html) supports only basic Prolog sintax, therefore it was not compatible with most of the existing Prolog code and extensions. Moreover its development was discontinued. The advantages of using this extension are:

* Cross-platform compatibility. GPJ was entirely devoloped in Java.
* Supports running multiple instances of the Prolog engine simultaneously, which can be very useful in multi-agent programming since it allows each agent having its own reasoner and knowledge base.

## Important notes

Before using the extension make sure you have installed the proper [NetLogo](http://ccl.northwestern.edu/netlogo/download.shtml) and SWI-Prolog versions. In this [link](http://www.swi-prolog.org/download/stable?show=all) you can find the different SWI-Prolog versions.

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
  * You can find out if this library is installed in your system by looking, within your SWI-Prolog installation, for the files *jpl.jar* and *libjpl.so*. The default paths of these files for SWI-Prolog 6.4.x in Ubuntu Trusty (14.04 LTS) are:
  * */usr/lib/swi-prolog/lib/amd64/libjpl.so*
  * */usr/lib/swi-prolog/lib/jpl.jar*

## Installation

* At this point you should have SWI-Prolog properly installed in your system (following the notes above).
* Go to the NetLogo folder. In *extensions* folder copy NetPrologo files. The files must look like:
 * */NetLogo x.x.x/extensions/netprologo/jpl.jar*
 * */NetLogo x.x.x/extensions/netprologo/netprologo.jar*
 * */NetLogo x.x.x/extensions/netprologo/config.txt* (this file is optional, details below)
* Add SWI-Prolog binaries path to your system PATH. These binaries are usualy found in:
 * **Windows:** *C:\Program Files (x86)\swipl\bin\* (there should be files like *libswipl.dll*, *jpl.dll*, etc)
  * [How to set the path and environment variables in Windows](http://www.computerhope.com/issues/ch000549.htm)
 * **Mac OS:** */opt/local/lib/swipl-x.x.x/lib/x86_64-darwinx.x.x/* (there should be files like *libjpl.so*)
 * **Linux:** */usr/lib/swi-prolog/lib/amd64/* (there should be files like *libjpl.dylib*, *libswipl.dylib*, etc.)
 * **IMPORTANT:** For Linux and Mac OS users, this step is not mandatory. The extension can set *java.library.path* programmatically. In this case you just have to add SWI-Prolog binaries path to the file *config.txt*. If you are not going to use this option delete *config.txt* file.

## How to use NetPrologo

In order to use NetProLogo load the extension in the first line of the model: {\ttk }.

```NetLogo
extensions[netprologo]
```

The following primitives are available:
