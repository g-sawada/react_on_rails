#!/bin/sh
set -e

# 自分のアプリに合わせて必要なコマンドを修正してください
bin/rails db:prepare
#bin/rails db:seed

exec "${@}"