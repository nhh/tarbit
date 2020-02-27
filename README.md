# Tarbit - A async ruby tcp tarpit

## Introduction

Tarbit is a tcp tarpit written in ruby. It can slow down automated ssh/http/tcp "attacks" or bot connections. 
It is designed to consume a very little amount of cpu and memory. Tarbit can also generate statistic images.

*"Red Wood Cutting", Vladimir Kush*

!["Red Wood Cutting", Vladimir Kush](.assets/red-wood-cutting_vladimir-kush.jpg)

## Installation

```
gem install tarbit
```

You can now run tarbit manually (you can also omit the default params):

The interval is the interval, the statistics are written to disk.

```
tarbit serve --port 22 --interval 600
```

## Advanced

Create a systemd service

Verify your tarbit executable: (change the path `bin` to `wrapper` within the systemd `ExecStart` )

```
which tarbit
```

```bash
[Unit]
Description=Tarbit - ruby ssh tarpit

[Service]
Type=simple
ExecStart=/usr/local/rvm/gems/ruby-2.6.5/wrappers/tarbit serve
AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
```

Create a cron job for making statistic snapshots:

Again make sure the path has changed `bin` with `wrapper`

```
*/15 * * * * /usr/local/rvm/gems/ruby-2.6.5/wrappers/tarbit snapshot
```

Enjoy statistics like these:

![A simple line graph showin connections over time](.assets/1582830001.png)
