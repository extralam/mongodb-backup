# mongodb-backup

[(DockerHub Link)](https://hub.docker.com/r/alangoxip/mongodb-backup/)
[`4.0`, `latest` (Dockerfile*)](https://github.com/extralam/mongodb-backup/blob/master/Dockerfile)
[`3.x`, `old` (*3.x/Dockerfile*)](https://github.com/extralam/mongodb-backup/blob/master/3.x/Dockerfile)

This image runs mongodump to backup data using cronjob to folder `/backup` , This mongodb backup docker support mongodb >=4 . 

## Usage:

    docker run -d \
        --env MONGODB_HOST=mongodb.host \
        --env MONGODB_PORT=27017 \
        --env MONGODB_USER=admin \
        --env MONGODB_PASS=password \
        --volume host.folder:/backup
        alangoxip/mongodb-backup

Moreover, if you link `alangoxip/mongodb-backup` to a mongodb container(e.g. official mongodb `mongo:latest`) with an alias named mongodb, this image will try to auto load the `host`, `port`, `user`, `pass` if possible.

    docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_PASS="mypass" --name mongodb mongo:latest
    docker run -d --link mongodb:mongodb -v host.folder:/backup alangoxip/mongodb-backup

## Parameters

    MONGODB_HOST    the host/ip of your mongodb database
    MONGODB_PORT    the port number of your mongodb database
    MONGODB_USER    the username of your mongodb database. If MONGODB_USER is empty while MONGODB_PASS is not, the image will use admin as the default username
    MONGODB_PASS    the password of your mongodb database
    MONGODB_DB      the database name to dump. If not specified, it will dump all the databases
    EXTRA_OPTS      the extra options to pass to mongodump command
    CRON_TIME       the interval of cron job to run mongodump. `0 0 * * *` by default, which is every day at 00:00
    MAX_BACKUPS     the number of backups to keep. When reaching the limit, the old backup will be discarded. No limit, by default
    INIT_BACKUP     if set, create a backup when the container launched

## Restore from a backup

See the list of backups, you can run:

    docker exec mongodb-backup ls /backup

To restore database from a certain backup, simply run:

    docker exec mongodb-backup /restore.sh /backup/2015.08.06.171901
