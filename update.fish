#!/usr/bin/env fish

mkdir deb-tmp

function build-go
    git clone https://github.com/acristoffers/$argv[1] src
    pushd src
    make pack
    popd
    find src -name "*.rpm" -exec cp {} rpm/ \;
    find src -name "*.deb" -exec cp {} deb-tmp/ \;
    rm -rf src
end

build-go cgen
build-go dbkp
build-go tmux-tui

for repo in void-rs ledger-formatter matlab-beautifier void-rs wbproto-beautifier
    pushd deb-tmp
    curl -sL https://api.github.com/repos/acristoffers/$repo/releases/latest | jq -r '.assets[] | select(.name | match("deb$")) | .browser_download_url' | xargs -n1 wget -c
    popd

    pushd rpm
    curl -sL https://api.github.com/repos/acristoffers/$repo/releases/latest | jq -r '.assets[] | select(.name | match("rpm$")) | .browser_download_url' | xargs -n1 wget -c
    popd
end

for codename in (grep Codename deb/conf/distributions | cut -d' ' -f2)
    for file in deb-tmp/*
        nix run nixpkgs#reprepro -- -b (pwd)/deb includedeb $codename $file
    end
end

nix shell nixpkgs#gnupg nixpkgs#rpm -c bash -c "sudo rpm --import repo-mgmt/pubkey.asc; rpmsign --macros=repo-mgmt/rpmmacros --resign rpm/*.rpm"
nix run nixpkgs#createrepo_c -- rpm
pushd rpm/repodata
gpg --default-key E18472E83DD7E6B8 --detach-sign --armor repomd.xml
popd

rm -rf deb-tmp
