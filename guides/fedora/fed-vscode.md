# Guide for using VSCode Devcontainers with podman on Fedora

- Install VSCode as a .rpm
- Install `podman-compose`
- Enable podman socket `systemctl enable --now podman.socket`
- Install the Devcontainers extension
- Goto the extension's settings
- Set the following values for the fields below:
    - `Dev > Containers: Docker Compose Path` set `podman-compose`
    - `Dev > Containers: Docker Path` set `podman`
    - `Dev > Containers: Docker Socket Path` set `/run/podman/podman.sock` (or whatever socket path `systemctl status podman.socket` shows)