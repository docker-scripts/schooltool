cmd_backup_help() {
    cat <<_EOF
    backup
        Make a data backup of the container '$CONTAINER'.

_EOF
}

cmd_backup() {
    local datestamp=$(date +%F)
    local dir=backup-$CONTAINER-$datestamp
    rm -rf $dir/
    mkdir -p $dir/data

    # copy the database and external files (blobs)
    ds exec repozo -B -v -r /host/$dir/data -f /var/lib/schooltool/Data.fs
    docker cp $CONTAINER:/var/lib/schooltool/blobs $dir/

    tar cfz $dir.tgz $dir/
    rm -rf $dir/
}
