# setup-dev-machine

An automated script to setup a mac dev machine with the necessary tooling to
perform package and image development.

Assuming you intend to run on a fresh machine (i.e no tools such as git), pull
down and run the script:

```bash
curl -O https://raw.githubusercontent.com/mamccorm/setup-dev-machine/main/install_tools.sh

chmod +x install_tools.sh
./install_tools.sh
```

If you are running on an existing machine where some tools are present, it'll
attempt to re-install the latest versions.
