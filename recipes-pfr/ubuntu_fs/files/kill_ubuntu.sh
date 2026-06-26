for p in /proc/[0-9]*; do
    pid=${p##*/}
    root=$(readlink $p/root 2>/dev/null)
    if [ "$root" != "/" ]; then
        echo "$pid $root"
	kill -9 $pid
    fi
done