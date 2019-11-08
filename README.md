# OpenSCAP in a container

This repository contains a Dockerfile and associated content that lets
you scan a system with openscap running in a container. The container is
based on RHEL-8 UBI. It is not intended to be used on its own, but rather
as a component of [the compliance operator](https://github.com/jhrozek/compliance-operator).

## How does the scan work?
The idea is that you mount the host's root filesystem to the container
with a volume, then the scanner would run `oscap-chroot`.

## Where do the binaries come from?
At the moment, RHEL proper does not build the `oscap-chroot` binary
that this container uses and lacks a couple of patches. Therefore,
the binaries are a rebuild of Fedora packages until RHEL picks up
all the changes. The packages are built in [this repo](https://copr.fedorainfracloud.org/coprs/jhrozek/openscap-with-chroot/)
in Fedora COPR.

## Configuration options
The configuration is done with environment variables. These are mandatory:
    - `HOSTROOT` - The location of the host filesystem mounted to the
                 container with a volume
    - `PROFILE` - The OpenSCAP profile to scan with
    - `CONTENT` - The OpenSCAP XML content which contains the profile
    - `REPORT_DIR` - The location where the XML report would be written

This env variable is optional:
    - `RULE` - Only run a single rule from the profile
