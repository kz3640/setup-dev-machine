# setup-dev-machine

An automated script for provisioning a macOS based host, with the necessary
tooling to perform package and image development.

Primarily utilizes brew, but some packages needed to be installed separately due
to ordering, and to work-around issues.

## How do I run this?
Assuming you are setting up a fresh macOS host (i.e no command line tools),
you'll not have access to 'git' yet. Download and execute the file as follows:

```bash
curl -O https://raw.githubusercontent.com/mamccorm/setup-dev-machine/main/install_tools.sh

chmod +x install_tools.sh
./install_tools.sh
```

## What happens if an applicastion already exists?
If an application already exists when you run this script, it'll re-install
the latest versions of the applications. This will not affect any cached data.

The reason for 'reinstall' - If an application was installed via brew (or cask)
and removed manually, it may still appear in brew list, meaning the script would
skip those and think they where installed.

## Applications installed

| Application               | Description |
|---------------------------|-------------|
| apko                      | Open-source tool for building container images, developed by Chainguard. |
| dive                      | Tool for exploring Docker image layer contents. |
| docker                    | CLI tools and desktop app for running containers. |
| grype                     | Open-source vulnerability scanner for containers. |
| kind                      | Tool for running local Kubernetes clusters using Docker nodes. |
| melange                   | Open-source tool by Chainguard for building Linux APK packages. |
| hashicorp/tap/terraform   | Infrastructure as code tool for orchestrating container image builds. |
| 1password                 | Password management app. |
| google-chrome             | Web browser. |
| slack                     | Communication app. |
| visual-studio-code        | Code editor. |
