# Nexus Repository 3 – Docker Setup

This repository contains the Dockerfile and instructions to run **Sonatype Nexus Repository 3** (version 3.68.1) with **data persistence**. Ideal for local use or testing before deploying to production.

---

## Running Locally
1. Create a volume for data persistence:
```bash
    docker volume create nexus-data
```

2. Start the container:
``` bash
    docker run -d \
        --name nexus \
        -p 8081:8081 \
        -v nexus-data:/nexus-data \
        sonatype/nexus3:3.68.1
```
> The `8081` port will be exposed on your machine. Adjust as needed.

---

## Accessing Nexus
1. Open your browser: http://localhost:8081
2. The `admin` user has the initial password stored at:
``` bash
    docker exec -it nexus cat /nexus-data/admin.password
```
3. Log in with `admin` and the displayed password.

---

## Maven Configuration (Java)

1. Create repositories in Nexus
    - Create a hosted repository for releases (e.g., `maven-releases`)
    - Create a hosted repository for snapshots (e.g., `maven-snapshots`)

2. Configure Maven `settings.xml`
```xml
    <settings>
        <servers>
            <server>
                <id>nexus-releases</id>
                <username>admin</username>
                <password>admin_password</password>
            </server>
            <server>
                <id>nexus-snapshots</id>
                <username>admin</username>
                <password>admin_password</password>
            </server>
        </servers>
    </settings>
```

3. Configure `pom.xml`
``` xml
    <distributionManagement>
        <repository>
            <id>nexus-releases</id>
            <url>http://localhost:8081/repository/maven-releases/</url>
        </repository>
        <snapshotRepository>
            <id>nexus-snapshots</id>
            <url>http://localhost:8081/repository/maven-snapshots/</url>
        </snapshotRepository>
    </distributionManagement>
```

---

## Logs
The Nexus logs are stored in the persistent volume:
```bash
    /nexus-data/log
```
- `nexus.log` → main server logs
- `karaf.log` → container and JVM logs

To access logs in real-time:

```bash
    docker exec -it nexus tail -f /nexus-data/log/nexus.log
```

## Backup and Persistence
- All Nexus content (artifacts, repositories, and configuration) is located in `/nexus-data`.

- For a simple backup:
```bash
    docker run --rm -v nexus-data:/data -v $(pwd):/backup busybox \
        tar czvf /backup/nexus-backup-$(date +%F).tar.gz -C /data .
```

## Notes
- For production, use **Nexus Pro** if you want cluster features and high availability.
- Adjust the JVM in the Dockerfile if you have many large artifacts.
- Always keep the `/nexus-data` volume to avoid losing artifacts.
