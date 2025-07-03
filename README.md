# Quickwit

## Description
[![Build Status](https://woodpecker.drycc.cc/api/badges/drycc/quickwit/status.svg)](https://woodpecker.drycc.cc/drycc/quickwit)

Drycc (pronounced DAY-iss) is an open source PaaS that makes it easy to deploy and manage
applications on your own servers. Drycc builds on [Kubernetes](http://kubernetes.io/) to provide
a lightweight, [Heroku-inspired](http://heroku.com) workflow.

## About
This is an debian based image for running [quickwit](http://quickwit.io/). It is built for the purpose of running on a kubernetes cluster.

## Development
The provided `Makefile` has various targets to help support building and publishing new images into a registry.

### Environment variables
There are a few key environment variables you should be aware of when interacting with the `make` targets.

* `BUILD_TAG` - The tag provided to the container image when it is built (defaults to the git-sha)
* `SHORT_NAME` - The name of the image (defaults to `quickwit`)
* `DRYCC_REGISTRY` - This is the registry you are using (default `registry.drycc.cc`)
* `IMAGE_PREFIX` - This is the account for the registry you are using (default `drycc`)

### Make targets

* `make build` - Build container image
* `make push` - Push container image to a registry

The typical workflow will look something like this - `DRYCC_REGISTRY= IMAGE_PREFIX=foouser make build push`