# Fedora

```bash
sudo dnf install https://acristoffers.github.io/repository/rpm/esousa-repo-1.0.0-1.fc$(rpm -E %fedora).noarch.rpm
```

# Ubuntu

```bash
curl -Lo /tmp/esousa-repo_1.0.0_noarch.deb https://acristoffers.github.io/repository/esousa-repo_1.0.0_noarch.deb
sudo apt install /tmp/esousa-repo_1.0.0_noarch.deb
```
