Teamspeak Server
================

Manage TS Server w/ Docker. Database and Logs are shared to `data` dir.

Usage
-----

Start TS Server in Background

```sh
$ make start
```

To stop the server call `make stop`


For debugging purposes there is `make run` to enter a teamspeak instance.


Setup
-----

Build the `wth-kist/teamspeak` image using `make build`
