---
layout: post
title:  "Set IntelliJ author name in OS X Yosemite"
date:   2015-06-20
categories: development
link: http://thedevelopersinfo.com/2009/12/15/changing-author-name-in-intellij-idea/
---

When IntelliJ auto-generates comments, the out-of-the-box configuration dumps your OSX username out in the comment:

```java
/**
 * Created by joeusername on 01/01/1970.
 */
```

Although most people can probably guess what my username is, I don't like broadcasting it when it can be avoided.  In
 order to change the value in the auto-generated code, update the `idea.vmoptions` file.  For OS X Yosemite and 
 IntelliJ IDEA Ultimate 14, this file is located at `/Applications/IntelliJ IDEA 14.app/Contents/bin/idea.vmoptions`.

Simply add the line `-Duser.name=<your name>` to the end of the file - for example:

```sh
echo "-Duser.name=Rob Mills" >> /Applications/IntelliJ IDEA 14.app/Contents/bin/idea.vmoptions
```

And if you've ever looked at my code, you'll know that I like to follow the Spring Code Format.  They've got a handy 
formatter file for your favorite IDE, but that formatter doesn't typically help with the auto-generated stuff like 
comments at the start of a Java class.  To do it, update the `ActionScript File Header` in the IntelliJ preferences 
located at `Editor > File and Code Templates > Includes > ActionScript File Header`:

```java
/**
 * @author ${USER}
 * @version 1.0
 * @since 
 */
```
