#!/bin/bash
#

# Start/stop script for resque-pool
#

NAME=resque-pool
KILL=/bin/kill
APP_ROOT=/src/HydraNorth
PIDFILE=$APP_ROOT/tmp/pids/$NAME.pid
OUTLOG=$APP_ROOT/log/$NAME.stdout.log
ERRLOG=$APP_ROOT/log/$NAME.stderr.log
ENV=development
PATH=$PATH:/usr/local/bin

if [ -f $PIDFILE ]; then
	PID=$(cat $PIDFILE)
fi

case "$1" in
        start)
                echo "starting $NAME . . ."
                cd $APP_ROOT
		            bundle exec resque-pool --daemon --environment $ENV 1>$OUTLOG 2>$ERRLOG
                if [ "$?" != 0 ]; then
                        echo "$NAME failed to start"
                else
                        echo "$NAME running, pool master started"
                fi
        ;;
        stop)
                kill -QUIT "$PID" && rm "$PIDFILE"
                echo >&2 "killed process $PID, pool master shutting down workers" && exit 0
        ;;
        restart)
                $0 stop
                $0 start
        ;;
        status)
                if [ -f $PIDFILE ]; then
                        echo "$NAME is running with pid $PID"
               else
                        echo "$NAME is stopped"
                fi
        ;;
        *)
                echo "Usage: $0 {start|stop|restart|status}"
        ;;
esac

exit 0

