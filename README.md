# pukiwiki

## Description

[PukiWiki 1.5.1 Unicode版](https://ja.osdn.net/projects/pukiwiki/downloads/64807/pukiwiki-1.5.1_utf8.zip/)をalpineとnginxで構成したもの。

## インストール

```shell
mkdir $HOME/pukiwiki
docker run -p 10080:80 -v $HOME/pukiwiki:/ext  -d pengo/pukiwiki
open http://localhost:10080
```

ディレクトリに既にデータがあるときは上書きしない。
