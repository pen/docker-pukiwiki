# pukiwiki

## Description

[PukiWiki 1.5.2 Unicode版](https://ja.osdn.net/projects/pukiwiki/downloads/69652/pukiwiki-1.5.2_utf8.zip/)をalpineとh2oで構成したもの。

## インストール

```shell
mkdir $HOME/pukiwiki
docker run -p 10080:80 -v $HOME/pukiwiki:/ext  -d pengo/pukiwiki
open http://localhost:10080
```

ディレクトリに既にデータがあるときは上書きしない。
