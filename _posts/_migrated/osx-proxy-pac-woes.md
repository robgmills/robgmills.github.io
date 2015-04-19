# [OSX Proxy Pac Woes](./osx-proxy-pac-woes)
- 2013/04/05
- Blog

Apple's OSX has a not-so-intuitive Network Settings interface.  We use a company-wide .pac file to improve security and network performance.  However, on the development team, we like to manage our own environments and this often leads to conflict with the more general company policies.  I encountered an issue where I couldn't access a development virtual machine running locally.  While fixing it I came across some really interesting information.

For starters, on a Mac, if you're using a .pac file to define your proxy rules, [OSX ignores the list of hosts and domains you've put in the little text area at the bottom of the screen](http://support.apple.com/kb/ht4654).

![OSX Network Settings Dialog](images/network-settings-pac.png)

Greying this box out would be awesome if you've checked the Automatic Proxy Configuration and provided it with a .pac file.  

You see, say I try to access the development vm using the host "devvm.local", one would expect that the pattern in the bypass settings, "*.local", would bypass the proxy.  Bzzzzzzzz!  The Network Settings delegate **ALL** rules to the .pac file.

That lead me to problem #2.  Summarizing the company's .pac file:

    function FindProxyForURL(url, host) {
        ...
        if(localHostOrDomainIs(host,".local")){ return "DIRECT"; }
        ....
        return "PROXY myproxy.foobar.com; DIRECT";
    }

According to the [documentation](http://findproxyforurl.com/pac-functions/), *localHostOrDomainIs()* should check to see if the first parameter -in this case "host"- ends with the second parameter -".local".  Thereby implying that any subdomain of "local" -such as "devvm.local"- would return true and bypass the proxy.

Again, Bzzzzzzzzzzzz!  For some reason, this failed to evaluate as true.  Instead, I had to do a regular expression match like so:

    function FindProxyForURL(url, host) {
        ...
        if(localHostOrDomainIs(host,".local")
                || shExpMatch(host, "*.local")){ 
            return "DIRECT";
        }
        ....
        return "PROXY myproxy.foobar.com; DIRECT";
    }

I left the original function that was returning false because according to the documentation, it should work and I just haven't had the time to figure out WHY it doesn't.

This led me to problem #3: A .pac file located on your localhost won't work in any browser on OSX unless it's located in a directory the browser has access to.  If you're loading it via http:// or ftp://, this isn't something you need to worry about.  That includes if you turn on Web Sharing and host the .pac file yourself.  OSX properly sandboxes the browser into a limited set of directories.  But that means that [resources being used by the browser need to be in that sandbox](https://discussions.apple.com/thread/3202499?start=15&amp;tstart=0).  For me, running Lion (OSX 10.7), that location is in `/Library/Internet Plug-Ins/`.  This is less of a problem now, as I've put it on a development server so the team can use it while we wait for official company-wide adoption.

Last, but certainly not least, I came across a great pro-tip.  I like to use Google Chrome to develop with because of the built in Firebug-esque Developer Tools.  But I didn't know about the [built in network debugging tools](http://www.chromium.org/developers/design-documents/network-stack/debugging-net-proxy), too.  Simply type `"chrome://network-internals"` into the omnibar and enjoy your new found fun!
