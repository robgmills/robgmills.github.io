---
layout: post
title: "Configuring openHAB with MongoLab"
date: 2015-12-18
categories: development
---

I had a few problems getting [openHAB][openhab] to connect to my free [MongLab][mongolab] database. 
The reason for it was stupid.  I needed to use the full mongo url provided by MongoLab including the
database path at the end, as well as specify the database in the `mongodb:database` property.

At first, I had configured the connection url using only the host and port.  On startup, I could see
openHAB attempting to establish the connection, but the resulting errors in the logs weren&rsquo;t 
terribly helpful:

> Failed to connect to database mongodb://ds012345.mongolab.com:12345

Digging into the code, the [exception handling][exception] was cause for suspect.

Final config:

```
############################ MongoDB Persistence Service ##################################
#
# the database URL, e.g. mongodb://127.0.0.1:27017
mongodb:url=mongodb://<dbuser>:<dbpass>@ds012345.mongolab.com:12345/openhab

# the database name
mongodb:database=openhab

# the collection name
mongodb:collection=openhab
```

Using mongo as my persistence store offers a few advantages:

0. I can easily reload the data if I ever need to rebuild my Raspberry Pi/openHAB setup.
0. I can use the time series data stored by openHAB as a test bed for my [Spark][spark] experiments
0. In particular, using MongoLab means I don&rsquo;t need to host and maintain a database myself.  My time 
is already scarce - by opting to "buy" rather than "build" I&rsquo;m saving a good amount of energy.

[openhab]: http://www.openhab.org/
[mongolab]: https://mongolab.com
[spark]: http://spark.apache.org
[exception]: https://github.com/openhab/openhab/blob/0ca751504d050b1059988f47280dc89e832e3e54/bundles/persistence/org.openhab.persistence.mongodb/java/org/openhab/persistence/mongodb/internal/MongoDBPersistenceService.java#L215
