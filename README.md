## NIX for GEWIS Radio

Nix config files for the machines used in the intro radio

TODO:
- Enable SSH on server
- Add file for secrets
- Add BUTT config files
- Add machine for Teams call + spotify
- Add machine for OBS

### Installation
```
nix-shell -p disko
sudo disko --mode disko --flake github:GEWIS/radionix#icecast-{client,host}
sudo nixos-install --no-channel-copy --no-root-password --flake github:GEWIS/radionix#icecast-{client,host}
```

### Update
```
sudo nixos-rebuild switch --flake github:GEWIS/radionix
```