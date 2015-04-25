daemonize
workers 2
threads 1, 6
pidfile "/var/run/puma_lnt.pid"
bind "unix:///var/run/lnt.sock"
