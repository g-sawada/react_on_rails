#applicationのディレクトリ名で置き換えてください
ARG APP_NAME=react-on-rails
#使いたいrubyのimage名に置き換えてください
ARG RUBY_IMAGE=ruby:3.2.3

FROM --platform=linux/amd64 $RUBY_IMAGE
ARG APP_NAME

# 環境はproduction
ENV RAILS_ENV production
# bundlerの実行もproductionモード
ENV BUNDLE_DEPLOYMENT true
# developmentやtestだけで必要なgemはインストールしない
ENV BUNDLE_WITHOUT development:test
# 自身で静的ファイルを配信する
ENV RAILS_SERVE_STATIC_FILES true
# Railsアプリのログを標準出力に出力
ENV RAILS_LOG_TO_STDOUT true

RUN mkdir /$APP_NAME
WORKDIR /$APP_NAME

RUN apt-get update -qq \
  && apt-get install -y ca-certificates curl gnupg \
  && mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && NODE_MAJOR=20 \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
  && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

  # ビルドツール，Node.js, Yarn, Vimのインストール
RUN apt-get update -qq && apt-get install -y build-essential libssl-dev nodejs yarn vim


# バンドラーのインストール
RUN gem install bundler

# ローカルのGemfileとGemfile.lockをイメージ内にコピー
COPY Gemfile /$APP_NAME/Gemfile
COPY Gemfile.lock /$APP_NAME/Gemfile.lock

RUN bundle install

# ローカルのyarn.lockとpakage.jsonをイメージ内にコピー
COPY yarn.lock /$APP_NAME/yarn.lock
COPY package.json /$APP_NAME/package.json

# ローカルのアプリケーションの全てのファイルとディレクトリをコピー
COPY . /$APP_NAME/

# 一時的なSECRET_KEY_BASEを生成し,それを使用してアセットのプリコンパイルとクリーニングを行う
RUN SECRET_KEY_BASE="$(bundle exec rails secret)" bin/rails assets:precompile assets:clean \
# package.jsonに記載されたパッケージをインストール。開発依存を除外し，yarn.lockは変更しないことを保証
&& yarn install --production --frozen-lockfile \
# yarnのキャッシュをクリーニング
&& yarn cache clean \
# node_modulesディレクトリとキャッシュディレクトリを削除して，イメージのサイズを小さくする
&& rm -rf /$APP_NAME/node_modules /$APP_NAME/tmp/cache

# Entrypoint prepares the database.(デフォルト生成から引用)
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# コンテナの3000番ポートを開放
EXPOSE 3000

CMD [ "sh", "-c", "rm -f tmp/pids/server.pid && bin/rails s" ]