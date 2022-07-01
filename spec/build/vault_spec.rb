require 'spec_helper'

describe "compiling", :sexp do
  let(:json) do
    '{
      "config": {
        ".result": "configured",
        "addons": {
          "apt": {
            "packages": [
              "bc"
            ]
          }
        },
        "env": [
          "FOO=bar"
        ],
        "vault": {
          "api_url": "http://127.0.0.1:8200",
          "token": "hvs.yOgBBXDy7fWVKgxyOkttAEFV",
          "secrets": [
            "root_3/dev_1/mash/dash"
          ]
        },
        "cache": "bundler",
        "global_env": [
          "CHIRP_SUMMARY_OUTPUT=\"${TRAVIS_BUILD_DIR}/chirp.json\"",
          "CHIRP_TRACKER_STATS_URL=\"https://chirp-tracker-staging.herokuapp.com/stats\"",
          "SITE=org"
        ],
        "language": "ruby",
        "linux_shared": {
          "addons": {
            "apt": {
              "packages": [
                "ww"
              ]
            }
          },
          "os": "linux"
        },
        "notifications": {
          "webhooks": {
            "on_failure": "never",
            "on_success": "always",
            "urls": [
              "https://chirp-tracker-production.herokuapp.com/travis"
            ]
          }
        },
        "os": "linux",
        "rvm": "default",
        "script": [
          "bundle exec rake"
        ],
        "sudo": false
      },
      "env_vars": [
        {
          "name": "hello",
          "public": false,
          "value": "yessy"
        }
      ],
      "job": {
        "allow_failure": false,
        "branch": "master",
        "commit": "a15c1259aeaf8e1955f01ed53abfa7cc5ef5e640",
        "commit_message": "Bump dyno=scheduler.4396",
        "commit_range": "f8e89280ead2...a15c1259aeaf",
        "debug_options": {},
        "id": 539369,
        "number": "18939.5",
        "pull_request": false,
        "queued_at": "2017-02-03T03:32:30Z",
        "ref": null,
        "secure_env_enabled": true,
        "state": "queued",
        "tag": null
      },
      "paranoid": false,
      "queue": "builds.macstadium6",
      "repository": {
        "api_url": "https://api.github.com/repos/travis-repos/chirp-org-staging",
        "default_branch": "master",
        "description": "chirp for staging.travis-ci.org",
        "github_id": 30708062,
        "id": 17192,
        "last_build_duration": 15,
        "last_build_finished_at": "2017-02-03T03:28:27Z",
        "last_build_id": 539357,
        "last_build_number": "18938",
        "last_build_started_at": "2017-02-03T03:23:02Z",
        "last_build_state": "canceled",
        "slug": "travis-repos/chirp-org-staging",
        "source_url": "https://github.com/travis-repos/chirp-org-staging.git"
      },
      "source": {
        "event_type": "push",
        "id": 539364,
        "number": "18939"
      },
      "ssh_key": null,
      "timeouts": {
        "hard_limit": null,
        "log_silence": null
      },
      "type": "test",
      "vm_type": "default"
    }'
  end


  let(:payload) { JSON.parse(json) }
  it do
    str = Travis::Build::Script.new(payload).sexp
    expect(1).to eq(1)
  end
end