workflow "Test and deploy" {
  on = "push"
  resolves = ["Deploy"]
}

action "Deploy" {
  uses = "Igor1201/pub-publish-action@master"
  secrets = ["PUB_ACCESS_TOKEN", "PUB_REFRESH_TOKEN", "PUB_EXPIRATION"]
  needs = ["Test"]
}

action "Test" {
  uses = "Igor1201/dart-test-action@master"
}
