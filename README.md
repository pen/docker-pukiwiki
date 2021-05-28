# pukiwiki

## Description

[PukiWiki Unicode版](https://pukiwiki.osdn.jp/)をalpineとh2oで構成したもの。

## インストール

```shell
mkdir $HOME/pukiwiki
docker run -p 8080:80 -v $HOME/pukiwiki:/ext -d pengo/pukiwiki
open http://localhost:8080
```

ディレクトリに既にデータがあるときは上書きしない。
