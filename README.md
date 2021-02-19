# pukiwiki

## Description

[PukiWiki 1.5.3 Unicode版](https://ja.osdn.net/projects/pukiwiki/downloads/72656/pukiwiki-1.5.3_utf8.zip/)をalpineとh2oで構成したもの。

## インストール

```shell
mkdir $HOME/pukiwiki
docker run -p 10080:80 -v $HOME/pukiwiki:/ext  -d pengo/pukiwiki
open http://localhost:10080
```

ディレクトリに既にデータがあるときは上書きしない。
