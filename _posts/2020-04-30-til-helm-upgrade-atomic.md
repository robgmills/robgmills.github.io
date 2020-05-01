---
layout: post
title: "TIL helm upgrade --atomic"
date: 2020-04-30
categories: development
link: https://helm.sh/docs/helm/helm_upgrade/
---

```sh
helm upgrade --atomic kafka incubator/kafka
```

Helm, in general, is new to me.
Really, the whole Kubernetes ecosystem is new to me.
_But Helm?_
Helm is a special beast - or so I hear.

I pulled some hands-on work recently - adding the [Google BigQuery datasource plugin](https://grafana.com/grafana/plugins/doitintl-bigquery-datasource/installation) for our [Grafana](https://grafana.com/) deployment(s) so that our mobile engineering teams can display qualitative app metrics on our internal dashboard.
Not a big task, for sure.
But it still required navigating our rough, _rough_ deployment process.
Along the way, I picked up some best practices for our team:

## Always `--name` your deployment

Helm allows you to install a chart without giving it an explicit name, but you probably really should.
It generates random names using [monicker](https://github.com/technosophos/moniker) (also written by the creator of Helm) and they come in the format `${ADJECTIVE}-${ANIMAL}` - e.g. `imprecise-numbat`.

If you run the same command but with different install targets - e.g. production vs qa - you'll end up with the same deployment, just with a different name.

This makes sense if you have a whole bunch of deployments running in the same Kubernetes cluster (and in the same namespace), but not so if you've only got one.
It just makes it harder to apply later upgrades to each of those environments.


## Use the `--atomic` option on upgrade

The `--atomic` option will automaticall roll back an upgrade if the deployment fails for some reason.
Failure reasons could include one or more of the [chart tests](https://helm.sh/docs/topics/chart_tests/) failing.
This makes it easy to build and execute smoke tests on your deployments, increasing your confidence in the changes.

## Don't deploy directly from an upstream reposotory

We have a monorepo of Helm charts and values files.
Many of those charts are copies of opensource charts found in [Helm Hub](https://hub.helm.sh/).
We prefer to `helm fetch --untar` charts from upstream repositories to our monorepo so that we have more control over our deployments.
(We also cache docker containers in a local repository.)

This means that if the [upstream chart were to ever disapper](https://hub.helm.sh/), we wouldn't miss a beat.

This also helps standardize our deployment process.
It's trivial, but if we're always installing or upgrading a chart from a filepath instead of by name, it reduces the complexity and likelihood that some issue arises.

## Skip chartmuseum

We started our Kubernetes and Helm journey by `helm package`-ing our proprietary Helm charts and uploading them to a [private chart repository](https://github.com/helm/chartmuseum).
Great practice in theory, but absolutely unnecessary complexity - especially since we're `fetch`-ing all third-party charts any way.
In effect, our git repository served as our chart repository.
Maintaining this extra piece of infrastructure and having to work in extra build and deployment steps just wasn't worth it.

____

### Disclaimer
Keep in mid this is specific to our environment.
You may be one of those special people running multiple cross-continent hybrid-prem-cloud Kubernetes clusters, but we aren't.
Our use case is pretty simple - some might even question if Kubernetes is worth it.
