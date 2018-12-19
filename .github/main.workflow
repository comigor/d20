workflow "New workflow" {
  on = "push"
  resolves = ["Publish to Pub"]
}

action "Publish to Pub" {
  uses = "Igor1201/pub-publish-action@master"
  secrets = ["PUB_ACCESS_TOKEN", "PUB_REFRESH_TOKEN", "PUB_EXPIRATION"]
}
