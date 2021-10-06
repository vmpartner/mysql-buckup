set -e

TAG="$(git describe --tags "$(git rev-list --tags --max-count=1)")"
echo "Build: $TAG"
docker build -t vmpartner/mysql-backup:"$TAG" .
echo "Push: $TAG"
docker push vmpartner/mysql-backup:"$TAG"
