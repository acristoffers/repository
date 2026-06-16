# Fedora

```bash
sudo dnf install https://acristoffers.github.io/repository/rpm/esousa-repo-1.0.0-1.fc$(rpm -E %fedora).noarch.rpm
```

# Ubuntu

```bash
curl -Lo /tmp/esousa-repo.deb https://acristoffers.github.io/repository/repo-mgmt/ubuntu/esousa-repo_1.0.0-$(grep UBUNTU_CODENAME /etc/os-release | cut -d= -f2)_noarch.deb
sudo chmod ugo+r /tmp/esousa-repo.deb
sudo apt install /tmp/esousa-repo.deb
```
