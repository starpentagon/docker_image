# Docker images for machine learning
## jupyter_base
Jupyter notebook用を利用するためのDockerイメージです。特徴は

* 必要最低限のパッケージのみインストール
* Jupyter notebookでコード補完が効く
* ホスト側の領域をゲスト側にマウントし永続化
* ゲストのJupyter notebookに外部から接続可能

です。

## Jupyter notebook接続用パスワードの設定
Jupyter notebook接続用のパスワードをハッシュ化したものを事前に設定しておく必要があります。まず
```
$ ./docker_build.sh
```
を実行し
```
$ docker run --rm -it jupyter_base
```
でコンテナに入ります。コンテナ内で
```
$ python3 ~/pass.py
```
を実行するとパスワードを聞かれるので入力すると
```
ARG JUPYTER_PASSWD='sha1:25e2bc817b10:917f1e38841d80dfa40535f60a88bc83c5228297'
```
などのハッシュ化されたパスワードが表示されるのでコピーしておきます。（sha1:以下は入力したパスワードに応じて変化します。）

コンテナで
```
$ exit
```
として終了して、ホストのDockerfileを開き
```
ARG JUPYTER_PASSWD=''
```
となっている部分を先ほどコピーした内容に書き換えます。

再度、
```
$ ./docker_build.sh
```
として
```
$ ./docker_run.sh
```
とするとコンテナが起動し、ホスト側からブラウザで http://localhost:8888 にアクセスするとJupyter notebookに接続できます。パスワードが求められるので（ハッシュ化する前の）パスワードを入力すると接続できます。

## スクリプトの保存先
ホスト側の./workディレクトリをゲスト側の~/workディレクトリにマウントしておりJupyter notebookで保存したノートブックはホスト側に保存されます。

## 外部からの接続
外部からブラウザで http://(ホスト側のIPアドレス):8888 にアクセスするとJupyter notebookに接続できます。

