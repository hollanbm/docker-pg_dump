Docker image with pg_dump. Find the image, here: https://ghcr.io/hollanbm/pg_dump

## Usage

Attach a target postgres container to this container and mount a volume to container's `/dump` folder. Backups will appear in this volume.

## Environment Variables:
| Variable            | Required? | Default  | Description                                                                              |
| ------------------- | :-------- | :------- | :--------------------------------------------------------------------------------------- |
| `PGUSER`            | Required  | postgres | The user for accessing the database                                                      |
| `PGPASSWORD`        | Optional  | `None`   | The password for accessing the database                                                  |
| `PGDB`              | Optional  | postgres | The name of the database                                                                 |
| `PGHOST`            | Optional  | db       | The hostname of the database                                                             |
| `PGPORT`            | Optional  | `5432`   | The port for the database                                                                |
| `DELETE_OLDER_THAN` | Optional  | `None`   | Optionally, delete files older than `DELETE_OLDER_THAN` days. Do not include `+` or `-`. |

Example:
```yaml
postgres-backup:
  image: ghcr.io/hollanbm/pg_dump
  container_name: postgres-backup
  links:
    - postgres:db #Maps postgres as "db"
  environment:
    - PGUSER=postgres
    - PGPASSWORD=SumPassw0rdHere
    - CRON_SCHEDULE=* * * * * #Every minute
    - DELETE_OLDER_THAN=1 #Optionally delete files older than $DELETE_OLDER_THAN minutes.
  #  - PGDB=postgres # The name of the database to dump
  #  - PGHOST=db # The hostname of the PostgreSQL database to dump
  volumes:
    - /dump
```

Run backup once without cron job, use "mybackup" as backup file prefix, shell will ask for password:

```shell
docker run -ti --rm \
  -v /path/to/target/folder:/dump \   # where to put db dumps
  -e PREFIX=mybackup \
  --link my-postgres-container:db \   # linked container with running mongo
  ghcr.io/hollanbm/pg_dump
```
