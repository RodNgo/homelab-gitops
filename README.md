# Rod Ngo Server Docker Swarm + GitOps
## 🏗 System Architecture

The following section describes the overall architecture of this homelab, deployed on a single Docker Swarm node.

It includes:
- Media automation
- Media consumption
- Cloud services
- Automation
- Monitoring
- Management

```mermaid
flowchart TB
    User[User / Web Browser]

    Homepage[Homepage Dashboard]
    Portainer[Portainer - Docker Swarm Management]
    BeszelHub[Beszel Hub - Monitoring UI]

    Jellyfin[Jellyfin - Media Server]

    Prowlarr[Prowlarr - Indexers]
    Radarr[Radarr - Movies]
    Sonarr[Sonarr - TV Shows]
    QBittorrent[qBittorrent - Downloader]
    Bazarr[Bazarr - Subtitles]
    Tdarr[Tdarr - Transcoding]

    Downloads[Downloads Directory]
    Media[Media Library]

    Nextcloud[Nextcloud - Personal Cloud]
    N8N[n8n - Workflow Automation]

    BeszelAgent[Beszel Agent - Host Metrics]

    User --> Homepage
    User --> Jellyfin
    User --> Nextcloud
    User --> N8N
    User --> Portainer

    Homepage --> Jellyfin
    Homepage --> Nextcloud
    Homepage --> N8N
    Homepage --> BeszelHub

    Portainer --> Jellyfin
    Portainer --> Media
    Portainer --> Nextcloud
    Portainer --> N8N

    Prowlarr --> Radarr
    Prowlarr --> Sonarr
    Radarr --> QBittorrent
    Sonarr --> QBittorrent

    QBittorrent --> Downloads
    Downloads --> Media

    Bazarr --> Media
    Tdarr --> Media

    Media --> Jellyfin

    BeszelAgent --> BeszelHub
    BeszelHub --> Homepage
```
