---
layout: post
title:  "Half measures: creating a single sign-on without a centralized authentication service"
date:   2012-01-04
categories: tech development engineering
---

I was presented with an interesting problem at work a few weeks ago: allow a user to log into multiple applications at the same time. Sounds simple right? It's called [Single sign-on](http://en.wikipedia.org/wiki/Single_sign-on) and it's [been](http://www.jasig.org/cas) [done](http://simplesamlphp.org/) a [million](ttp://openid.net/developers/) [times](http://code.google.com/apis/accounts/).

Almost all the [suggested design patterns](http://www.ibm.com/developerworks/web/library/wa-singlesign/) for a single sign-on authentication involve having a centralized authentication service (CAS) that actually performs the authentication and returns the now authenticated user to the application they were originally trying to view. Its a pretty well established pattern that's worked great for Google's services, among others, so why wouldn't we want to follow the same pattern?

Ha! I can't tell you. Against our (development team) urging, we were told that implementing a true single sign-on via CAS wasn't an option. We didn't "have time for it," or we didn't "have the budget for it." (More on these later) Whatever the reason, our parameters were pretty clearly laid out: make it so that when a user logs into one application, they are logged in to the others... without implementing a centralized authentication service.

We tried to put the idea of SSO via CAS out of our minds and went down a different path - and failed. And then a different path - and failed. Until finally, we took a good hard look at exactly how the CAS model worked and used parts of it to come up with our solution. Our final solution basically did the same thing, but opted to redirect to a secure url within the same application to do the authentication, rather than out to a separate authentication service.

Each application would have the ability to log a user in. Upon log in, Application A would drop 2 cookies:

- Cookie Z - a SECURE cookie that contained the encrypted, obfuscated, and temporary identifying information of the user who just logged in. By putting the identifying information in a secure cookie that's only passed over HTTPS, we prevent cookie hijacking.
- Cookie Y - an INSECURE cookie that essentially alerted applications reading this cookie that there was an accompanying secure cookie. It contained the names of the applications that had read it and successfully logged the user in. More about the value stored in just one second.

When a user then visits Application B, a filter would detect the presence of Cookie Y, the insecure cookie, and check to make sure that "Application B" wasn't stored anywhere in the cookie value. Why? If we didn't check to see if this application had already logged the user in, the user would enter a redirect loop. Assuming that Application B hasn't already logged the user in, the filter would redirect to a url within Application B that's served over HTTPS, thereby giving the application access to Cookie Z where the identifying information was found. Behind that url is a servlet that reads in Cookie Z, performs its checks to make sure its a valid secure cookie, logs the user in, adds "Application B" to the value of the secure cookie (remember to avoid the redirect loop), then redirects the user to the original url they requested within Application B.

Another thing - since our applications have been developed over the better part of 15 years now, each one had its own way of storing session information. One application stored a User object in the HttpSession while another used Spring Security and kept a principal in the SecurityContext. Since the logged in states were all unique to each application, it was impossible to make all of this code its own library. I was able to pull the filter, servlet, and cookie service (that handled all of the operations regarding the cookies) out into its own library. The applications then had their their own login service (that implemented a login interface also found in the library) that's injected into the servlet via Spring. Basically it's plug-and-play. Just drop the library in, add the filter to the filter chain and away we go. It made it really easy to drop into our other applications and definitely increased the security across the board.

That said, this isn't a solution I'd recommend for most people. Really, for anybody. Yeah it works, but it came at a big cost. The logins aren't exactly seamless across the applications. And I HATE, HATE, HATE putting identifying information in cookies. No matter how encrypted, obfuscated, and temporary the information is, it's just not a good idea. Not to mention, it took a number of iterations to get to this solution. We did it in ways that just didn't cut it about 3 times before we came up with this solution. Each of those tries cost us about 40 man hours of development time, and I don't even know how many man hours of QA time. In the end I think we spent more time (and therefore more money) taking the route we did because of business constraints and ended up at almost the way we should have done it the first time through. Would we have nailed it the first time if we used CAS? Probably not. But I bet we would have been much closer after round 1, and worked out any bugs in round 2.

I'm catching up on this TV series by amc called Breaking Bad. In one of the episodes, one character is imparting wisdom to the other warning him against half measures to solve your problems.

![:youtube](n3u-6UFLubI)

> I chose a half measure, when I should have gone all the way.