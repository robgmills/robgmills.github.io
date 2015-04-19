# [Use hawt.io for ActiveMQ web monitoring](./hawtio-activemq-web-monitoring)
- 2014/05/20
- Tech

The documentation at Apache for ActiveMQ's integration in their Karaf OSGi 
container is a little out-of-date.  Installing the `activemq` bundles from 
the repo doesn't make available the troubleshoot-friendly web console 
typically available with at OOTB, basic AMQ install.

At the time of this writing, the documentation states that it was last 
tested with Karaf 2.3.0 and the current version of Karaf is 3.0.1.  To be 
clear, these instructions are for Karaf 3.0.1 and ActiveMQ 5.9.1 and are 
not guaranteed to work with other versions.  But I hope they help others 
in their endeavors.

**WARNING**: If at any time the `activemq-broker` feature is installed, it 
is impossible to uninstall it from the konsole.  The installation and 
activation of ANY of the bundles from the `activemq` repo will start 
a broker within the Karaf container on port `61616`.

So let's begin:

Add the `activemq` repo:

    $ feature:repo-add activemq 5.9.1
    $ feature:list | grep -i activemq

We can now see that the following features are available for installation:

- activemq-client - Just the client libraries
- activemq-broker - A full-fledged message broker and is *supposed* to 
include a web console to help monitor the running broker - all wired 
together (depends on activemq and activemq-web-console)
- activemq-broker-noweb - A full-fledged message broker without any fancy
web console
- activemq-web-console - A web application that can connect to and 
provide information about a running message broker
- activemq - Some of the broker libraries, but doesn't actually contain
a broker (I think)
- some others I didn't really care about

You now have to decide:

> Do I want to Karaf to manage my message broker?

If you answered "no," do yourself a favor and only install what you need, 
which is just the `activemq-client` feature:

    $ feature:install activemq-client

If you answered "yes," install just the `activemq-broker-noweb` feature:

    $ feature:install activemq-broker-noweb

The `activemq-web-console` (and by proxy, the `activemq-broker`) feature
is broken.  It doesn't work.  At all.  So it's pointless to install it.

If you want some sort of web admin for your broker, 
[hawt.io](http://hawt.io/) is super easy to 
[get installed](http://hawt.io/getstarted/index.html) and running in 
Karaf.  Though, I do it a bit differently than they suggest, the net
effect is the same:

    $ feature:repo-add hawtio 1.4.0
    $ feature:install hawtio