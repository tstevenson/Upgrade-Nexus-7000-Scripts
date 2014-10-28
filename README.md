Upgrade-Nexus-7000-Scripts
==========================

Master perl script, and child TeraTerm Macro scripts, used to upgrade Nexus 7000/7700 switches.

Originally developed for internal (to Cisco) technical marketing lab environment, where switch images are changed frequently on many switches. Feel free to use as you see fit.

Some of the includes use static paths, sorry 'bout that. Search for "include" and fix as necessary in the .ttl files. Apply IPs, hostnames, etc. as necessary (search for w.x.y.z, a.b.c.d, foo, example.com, etc.).

Structure/relationship of files looks like this (view in Raw mode):

upgrade-image-on-switch(es).pl
  |
  |-init-config-(current-switch).ttl
  |   |
  |   |-GENERIC-n7k-abort-setup.ttl
  |   |
  |   |-GENERIC-n7k-base-config.ttl
  |   |
  |   |-(current-switch)-config.ttl
  |   |
  |   |-GENERIC-n7k-write-config.ttl
  |
  |
  |-INFRA-upgrade-n7k-switch.ttl
      |
      |-passwords.ttl
      |
      |-INFRA-rationalize-image-names.ttl
      |
      |-erase-switch-config.ttl
      |
      |-reload-switch.ttl

